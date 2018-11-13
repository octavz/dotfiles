import org.apache.spark.sql.SparkSession

val spark = SparkSession.builder().appName("test").getOrCreate()

import spark.implicits._

/////////////////
import java.sql.Timestamp
import rfs.blaze.product.merge.data.json._
import rfs.blaze.product.merge.data.Details

import KafkaDetailsMarshalling._

//val kafkaBrokers = "10.200.8.176:9092"

val kafkaBrokers = "10.204.37.154:9092"

case class KafkaRec(key: String, value: String, offset: Long, timestamp: Timestamp)

def kafkaStream(topic: String, fromStart: Boolean = false) =
  spark.readStream.format("kafka")
    .option("kafka.bootstrap.servers", kafkaBrokers)
    .option("subscribe", topic)
    .option("startingOffsets", if (fromStart) "earliest" else "latest")
    .option("failOnDataLoss", "false")
    //.option("maxOffsetsPerTrigger", 1)
    .load()

val dsProduct = kafkaStream("product", true)
  .selectExpr("CAST(key as STRING)", "CAST(value as STRING)", "CAST(offset AS LONG)", "CAST(timestamp AS TIMESTAMP)")
  .as[KafkaRec]
  .dropDuplicates("key")
  .map { rec =>
    spray.json.JsonParser(rec.value).convertTo[Details]
  }

val dsInventory = kafkaStream("inventory")
  .selectExpr("CAST(key as STRING)", "CAST(value as STRING)", "CAST(offset AS LONG)", "CAST(timestamp AS TIMESTAMP)")
  .as[KafkaRec]
  .dropDuplicates("key")
  .map(rec => KafkaRec(rec.key.split("/").head, rec.value, rec.offset, rec.timestamp))
  .withWatermark("timestamp", "1 hour")
  .groupByKey(_.key).mapGroups { (_, vals) =>
  vals.toList
}


//val joined = dsProduct.join(dsInventory, "key")

//joined.writeStream.format("memory").queryName("inventory").start()

val ds = dsProduct.writeStream
  .format("memory")
  .queryName("product")
  .start()

/*val ds = dsInventory.writeStream
  .format("memory")
  .queryName("inventory")
  .start()*/

