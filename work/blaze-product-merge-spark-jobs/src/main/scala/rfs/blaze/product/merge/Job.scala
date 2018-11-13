package rfs.blaze.product.merge

import org.apache.spark.sql._
import org.slf4j.LoggerFactory
import rfs.blaze.product.merge.conf.ArgsParser
import rfs.blaze.product.merge.data.ArgsParams

//Needed for test, for classOf[Job]
case class Job()

object Job {

  private lazy val logger = LoggerFactory.getLogger(Job.getClass)

  val appName = "FilesProcessor"

  def main(args: Array[String]): Unit = {
    val defaultArgs = ArgsParams()
    val spark = SparkSession.builder().appName(appName).getOrCreate()

    ArgsParser(appName).parse(args, defaultArgs) match {
      case Some(config) ⇒ ???
      case None ⇒ System.exit(1)
    }
  }

}
