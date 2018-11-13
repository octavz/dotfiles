package rfs.blaze.product.merge.cmd

import org.apache.spark.sql._
import org.apache.spark.sql.streaming._
import cats.implicits._
import org.slf4j.Logger
import rfs.blaze.product.merge._
import rfs.blaze.product.merge.data._

case class KafkaRec(key: String, value: String, offset: Long, topic: String)

class GenericForeach[T](callback: T ⇒ Unit) extends ForeachWriter[T] {
  override def open(partitionId: Long, version: Long) = true

  override def process(value: T): Unit = callback(value)

  override def close(errorOrNull: Throwable): Unit = ()
}

trait KafkaLoadGeneric[T <: Serializable] extends Serializable {

  import rfs.blaze.product.merge.JobRun

  protected val logger: Logger

  private[cmd] def source(): JobRun[Dataset[KafkaRec]] = ask map { env ⇒
    import env.spark.implicits._
    logger.info(s"Sourcing data from ${env.args.kafkaFilesTopic}")
    env.spark.readStream
      .format("kafka")
      .option("kafka.bootstrap.servers", env.args.kafkaBrokersAsString)
      .option("subscribe", env.args.kafkaFilesTopic)
      .option("startingOffsets", "earliest")
      .option("failOnDataLoss", "false")
      .option("maxOffsetsPerTrigger", 1)
      .load()
      .selectExpr("CAST(key as STRING)", "CAST(value AS STRING)", "CAST(offset AS LONG)", "CAST(topic AS STRING)").as[KafkaRec]
  }

  def runCallback(call: T ⇒ Unit): JobRun[DataStreamWriter[T]] = run(new GenericForeach(call))

  def run(w: ForeachWriter[T]): JobRun[DataStreamWriter[T]] = for {
    env ← ask
    ds ← source()
  } yield {
    loadInternal(env, ds)
      .writeStream
      .option("checkpointLocation", env.args.checkpointPath)
      .foreach(w)
  }

  protected[cmd] def loadInternal(env: Env, ds: Dataset[KafkaRec]): Dataset[T]

}

