package rfs.blaze
package files.processor
package conf

import java.net.URL
import java.time.LocalDateTime

import scala.collection.JavaConversions._

import io.prometheus.client.Collector.MetricFamilySamples
import io.prometheus.client.CollectorRegistry
import io.prometheus.client.dropwizard.DropwizardExports
import io.prometheus.client.exporter.PushGateway
import com.codahale.metrics._

object MetricsConf {

  import org.slf4j.LoggerFactory

  private val metrics = new MetricRegistry
  private lazy val logger = LoggerFactory.getLogger(MetricsConf.getClass)

  class WehkampMetricsExporter(m: MetricRegistry) extends DropwizardExports(m) {

    override def collect() =
      super.collect().map { family ⇒
        val all = family.samples.map(s ⇒
          new MetricFamilySamples.Sample(s"db_spark_${s.name}", s.labelNames, s.labelValues, s.value, s.timestampMs))
        new MetricFamilySamples(family.name, family.`type`, family.help, all)
      }
  }

  def withHost(str: String) = s"${str}_${java.net.InetAddress.getLocalHost.getHostName}"

  def findGauge(name: String): Option[Gauge[_]] =
    metrics.getGauges(new MetricFilter {
      override def matches(n: String, metric: Metric): Boolean = name.equals(n)
    }).headOption.map(_._2)

  def gauge[T](name: String, value: T): Gauge[T] = {
    logger.info(s"$name = $value")
    val g = findGauge(name)
    if (g.isDefined) metrics.remove(name)
    metrics.register(name, new Gauge[T] {
      override def getValue = value
    })
  }

  CollectorRegistry.defaultRegistry.register(new WehkampMetricsExporter(metrics))

  def apply() = metrics

  def push(gatewayUrl: String, root: String): Unit = {
    val pushGateway = new PushGateway(new URL(gatewayUrl))
    logger.info(s"Pushing metrics to $root-spark: instance")
    scala.util.Try(pushGateway.push(CollectorRegistry.defaultRegistry, s"$root-spark", Map("instance" → s"inst")))
      .getOrElse {
        logger.info(s"Failed to push metrics to $gatewayUrl")
      }
  }

}
