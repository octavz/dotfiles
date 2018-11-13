package rfs.blaze.product.merge.conf

import rfs.blaze.product.merge.data.ArgsParams
import scopt.OptionParser

object ArgsParser {

  def apply(appName: String) = new OptionParser[ArgsParams](appName) {
    override def showUsageOnError = true

    head("Data Retention", getClass.getPackage.getImplementationVersion)

    opt[Seq[String]]("kafka-hosts")
      .valueName("<host:port>,<host:port>...")
      .text("Kafka broker to connect to")
      .action((x, c) ⇒ c.copy(kafkaBrokers = x))

    opt[String]("kafka-files-topic")
      .valueName("<path>")
      .text("The source data topic")
      .action((x, c) ⇒ c.copy(kafkaFilesTopic = x))

    opt[String]("transient-source")
      .valueName("<path>")
      .text("The place where to put the files")
      .action((x, c) ⇒ c.copy(transientSource = x))

    opt[String]("raw-destination")
      .valueName("<path>")
      .text("The place where to put the files")
      .action((x, c) ⇒ c.copy(rawDestination = x))

    opt[String]("generic-rsa-key")
      .valueName("<path>")
      .text(s"A generic rsa key used for encrypting data")
      .action((x, c) ⇒ c.copy(genericRSAKey = x))

    opt[String]("prometheus-gateway")
      .valueName("<path>")
      .text(s"The Prometheus gateway where this job should send the metrics")
      .action((x, c) ⇒ c.copy(prometheusGateway = x))

    help("help").text("prints this usage text")
    version("version")
    note(
      """
        | Applies a flow to a file that arrives to transient zone in Data Lake
      """.stripMargin
    )
  }
}

