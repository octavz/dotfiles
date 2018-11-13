package rfs.blaze
package product.merge
pacakge cmd

import scala.concurrent._
import duration._

import org.apache.spark.sql.streaming.DataStreamWriter
import org.scalatest.concurrent.PatienceConfiguration._
import org.apache.kafka.clients.producer.ProducerRecord
import data._
import helpers._
import helpers.Implicits._

object Outer {
  def process(value: FileEvent): Unit = {
    println(s"Processing ${value.id}")
    TestDb().put(value.id, value.key).get
    ()
  }

  def process(counterName: String)(value: FileEvent): Unit = {
    println(s"Processing ${value.id}")
    TestDb.inc(counterName)
    TestDb().put(value.id, value.key).get
    ()
  }
}

class KafkaLoadTest extends TestBase {

  import Outer._

  def loadK(env: Env)(c: FileEvent ⇒ Unit): DataStreamWriter[FileEvent] =
    evalAppRunGet(env)(S3EventsLoader.runCallback(c))._2

  override def beforeEach(): Unit = {
    TestDb.clean()
  }

  /*  def loadK(env: Env)(c: ForeachProcessor): DataStreamWriter[FileEvent] =
      evalAppRunGet(env)(S3EventsLoader.run(c))._2*/

  it should "read the input topics" in {
    withKafkaAndSpark(topic) {
      case (env, prod) ⇒
        Seq(msg("1"), msg("2")).map(m ⇒ Await.result(prod.send(m), timeout))
        loadK(env)(process).start()
        eventually(Timeout(10.seconds), Interval(10.millis)) {
          TestDb().keys should contain allElementsOf Seq("1", "2")
        }
    }
  }

  it should "skip bad messages" in {
    withKafkaAndSpark(topic) {
      case (env, prod) ⇒
        Seq(new ProducerRecord(topic, "s", ""), msg("2")).map(m ⇒ Await.result(prod.send(m), timeout))
        loadK(env)(process).start()
        eventually(Timeout(10.seconds), Interval(10.millis)) {
          TestDb().keys should contain allElementsOf Seq("2")
        }
    }
  }

  it should "correctly resume from checkpoint" in {
    withTemp { tmp ⇒
      val checkPath = s"${tmp.getAbsolutePath}/${java.util.UUID.randomUUID().toString}"
      withKafka(topic) {
        case (envKafka, prod) ⇒
          withSpark { envSpark ⇒
            val e = envSpark.copy(args = envKafka.args)
            val env = e.copy(args = e.args.copy(checkpointPath = checkPath))
            val keys = (1 to 10).map(i ⇒ s"a$i")
            keys.map(k ⇒ msg(k)).map(m ⇒ Await.result(prod.send(m), timeout))
            val s = loadK(env)(process).start()
            eventually(Timeout(10.seconds), Interval(10.millis)) {
              TestDb().keys should contain allElementsOf keys
            }
            s.stop()
            Thread.sleep(1000)
          }
          withSpark { envSpark ⇒
            val counter = java.util.UUID.randomUUID().toString
            val e = envSpark.copy(args = envKafka.args)
            val env = e.copy(args = e.args.copy(checkpointPath = checkPath))
            val keys = (1 to 10).map(i ⇒ s"b$i")
            keys.map(k ⇒ msg(k)).map(m ⇒ Await.result(prod.send(m), timeout))
            loadK(env)(process(counter)).start()
            eventually(Timeout(10.seconds), Interval(10.millis)) {
              TestDb.getInt(counter).get should be >= 10
              TestDb.getInt(counter).get should be <= 11
              TestDb().keys should contain allElementsOf keys
            }
          }
      }
    }
  }

  it should "correctly resume from latest offset" in {
    withTemp { _ ⇒
      withKafkaAndSpark(topic) {
        case (env, prod) ⇒
          println(env)
          val keys = (1 to 10).map(i ⇒ s"a$i")
          keys.map(k ⇒ msg(k)).map(m ⇒ Await.result(prod.send(m), timeout))
          loadK(env)(process).start()
          eventually(Timeout(10.seconds), Interval(10.millis)) {
            TestDb().keys should contain allElementsOf keys
          }

          val keys1 = (1 to 10).map(i ⇒ s"b$i")
          keys1.map(k ⇒ msg(k)).map(m ⇒ Await.result(prod.send(m), timeout))
          eventually(Timeout(10.seconds), Interval(10.millis)) {
            TestDb().keys should contain allElementsOf keys1
          }
      }
    }
  }
}