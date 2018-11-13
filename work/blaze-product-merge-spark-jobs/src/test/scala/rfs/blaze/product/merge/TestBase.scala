package rfs.blaze
package files.processor

import java.io.File
import java.util.UUID
import java.util.Properties

import org.apache.spark.sql.SparkSession
import org.apache.kafka.common.serialization.StringSerializer
import org.apache.kafka.clients.producer._
import org.scalatest.concurrent.Eventually

import org.scalatest._
import scala.concurrent._
import scala.concurrent.duration._
import scala.util.Try

import cats.effect.IO
import rfs.blaze.it._
import rfs.blaze.it.env._
import data._
import helpers.Implicits._

trait TestBase extends FlatSpec with Matchers with IntegrationTestSetup with Eventually with BeforeAndAfterEach {

  type Eff[+A] = IO[A]
  protected def resource(file: String): String = new File(s"src/test/resources/$file").getAbsolutePath

  protected val tempFolder = "/tmp/spark-files-processor"

  protected val topic = "s3-files"
  protected val timeout = 2.seconds

  def msg(key: String, t: String = topic) = {
    val m =
      s"""
         |{
         |  "eventVersion": "2.0",
         |  "eventSource": "aws:s3",
         |  "awsRegion": "eu-west-1",
         |  "eventTime": "2018-09-10T08:06:13.682Z",
         |  "eventName": "ObjectCreated:Put",
         |  "userIdentity": {
         |    "principalId": "AWS:AIDAI66W36TZJEXSXZUSG"
         |  },
         |  "requestParameters": {
         |    "sourceIPAddress": "34.247.163.2"
         |  },
         |  "responseElements": {
         |    "x-amz-request-id": "DBDEA2845457DEDC",
         |    "x-amz-id-2": "nz0xqIXAFG+QTUyBwcj4CIHbdR7Ngm4uOitHwq7IKu+pqeIDUhrXL6kATf2eCJrCQUoEyrKjCls\u003d"
         |  },
         |  "s3": {
         |    "s3SchemaVersion": "1.0",
         |    "configurationId": "92a02af7-b7c0-4ddc-a160-ec740dd50da9",
         |    "bucket": {
         |      "name": "wehkamp-databricks-resources",
         |      "ownerIdentity": {
         |        "principalId": "A1RI95B02PP5CW"
         |      },
         |      "arn": "arn:aws:s3:::wehkamp-databricks-resources"
         |    },
         |    "object": {
         |      "key": "logs/itemitem_seed_prod/0910-074613-torn308/executor/app-20180910074747-0000/12/stdout",
         |      "size": 103906,
         |      "eTag": "f50aca1ba1e624208e89e9e58ee34ee4",
         |      "versionId": "HZjAcUfaNqNPToqP7LU1lfwB.HuBZ9wE",
         |      "sequencer": "$key"
         |    }
         |  }
         |}
      """.stripMargin

    new ProducerRecord(t, key, m)
  }

  def withSpark[A](call: Env ⇒ A, forceNewSpark: Boolean = true): A = {
    import org.apache.commons.io.FileUtils
    import org.apache.kafka.common.utils.AppInfoParser
    (1 to 100).foreach { i ⇒
      AppInfoParser.unregisterAppInfo("kafka.consumer", s"consumer-$i")
      AppInfoParser.unregisterAppInfo("kafka.producer", s"producer-$i")
    }
    val session = SparkSession.builder().master("local[*]")
      .appName("FilesProcessor")
      .getOrCreate()
    val checkpointPath = s"/tmp/test/spark-files-processor/checkpoints/${UUID.randomUUID().toString}"
    val newArgs = defaultEnv.args.copy(checkpointPath = checkpointPath)
    val res = call(defaultEnv.copy(spark = session).copy(args = newArgs))
    //removed default spark isolation since on local sbt it will run out of memory pretty fast
    if (forceNewSpark) {
      println("Shutting down and cleaning Spark")
      if (session != null) {
        session.stop()
      }
    }
    FileUtils.deleteDirectory(new File(checkpointPath))
    res
  }

  def withKafka[A](topics: String*)(call: (Env, KafkaProducer[String, String]) ⇒ A): A = {
    val p = Promise[A] //use as holder
    withPrerequisites(List(Services.KafkaWithZookeeper)) {
      case prereq @ TestPrerequisites(env) ⇒
        topics foreach env.newTopic
        val props = new Properties()
        val kafkaAddress = env.addressAsString(env.kafkaId)
        val newArgs = defaultEnv.args.copy(
          kafkaBrokers = Seq(kafkaAddress),
          kafkaFilesTopic = topics.head
        )
        val newEnv = defaultEnv.copy(args = newArgs)
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, kafkaAddress)
        props.put(ProducerConfig.CLIENT_ID_CONFIG, "producer-" + UUID.randomUUID().toString)

        val producer = new KafkaProducer(props, new StringSerializer, new StringSerializer)
        p.complete(Try(call(newEnv, producer)))
        producer.close()
    }
    Await.result(p.future, Duration.Inf)
  }

  val defaultEnv = Env(null, ArgsParams(), null)

  def withKafkaAndSpark[A](topics: String*)(call: (Env, KafkaProducer[String, String]) ⇒ A): A =
    withSpark(env ⇒ withKafka(topics: _*)((kEnv, producer) ⇒ {
      val newArgs = env.args.copy(kafkaBrokers = kEnv.args.kafkaBrokers, kafkaFilesTopic = kEnv.args.kafkaFilesTopic)
      call(env.copy(args = newArgs), producer)
    }))

  def withTemp(call: File ⇒ Assertion): Unit = {
    import org.apache.commons.io.FileUtils
    val rootTemp = new File(tempFolder)
    if (!rootTemp.exists()) rootTemp.mkdir()
    val tmp = new File(s"$tempFolder/${UUID.randomUUID().toString}")
    tmp.mkdir()
    tmp.exists() shouldBe true
    call(tmp)
    FileUtils.deleteDirectory(tmp)
  }

}

