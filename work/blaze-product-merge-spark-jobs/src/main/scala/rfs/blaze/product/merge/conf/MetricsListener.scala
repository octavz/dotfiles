package rfs.blaze.product.merge.conf

import org.slf4j.LoggerFactory
import org.apache.spark.sql.streaming.StreamingQueryListener

object MetricsListener extends StreamingQueryListener {

  import StreamingQueryListener._

  private lazy val logger = LoggerFactory.getLogger(MetricsListener.getClass)

  override def onQueryStarted(event: QueryStartedEvent): Unit = ()

  override def onQueryProgress(event: QueryProgressEvent): Unit =
    Option(event.progress) foreach { progress ⇒
      //      logger.info(progress.prettyJson())
    }

  override def onQueryTerminated(event: QueryTerminatedEvent): Unit = ()
}
