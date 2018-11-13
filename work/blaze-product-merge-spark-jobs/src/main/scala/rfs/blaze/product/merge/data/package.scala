package rfs.blaze.product

import cats.data._
import cats.effect._
import rfs.blaze.product.merge.data._

package object merge {

  import org.apache.spark.sql.SparkSession

  case class ArgsParams(
    kafkaBrokers: Seq[String] = Seq("queue.nl.wehkamp.dev.blaze.ps:9092"),
    kafkaFilesTopic: String = "dl-transient-general",
    filesTarget: String = "",
    transientSource: String = "/mnt/nl-wehkamp-dl-transient",
    genericRSAKey: String = "",
    rawDestination: String = "/mnt/nl-wehkamp-dl-raw/",
    checkpointPath: String = "/tmp/files-processor/checkpoint",
    prometheusGateway: String = "https://prometheus-pushgateway.trusted.nl.wehkamp.dev.blaze.ps"
  ) {
    val kafkaBrokersAsString = kafkaBrokers.mkString(",")
  }

  case class Env(spark: SparkSession, args: ArgsParams)

  case class FileConf(source: String, destinationPath: String, destinationFilename: String, key: String)

  case class ST(data: List[String] = List.empty)

  type Metrics = List[(String, Long)]
  type AppEffect[A] = IO[A]
  type AppState[A] = StateT[AppEffect, ST, A]
  type JobRun[A] = ReaderT[AppState, Env, A]

  def liftF[A](x: AppState[A]): JobRun[A] = ReaderT.liftF[AppState, Env, A](x)

  def liftF[A](x: IO[A]): JobRun[A] = {
    liftF(StateT.liftF[IO, ST, A](x))
  }

  def safe[A](v: ⇒ JobRun[A]): JobRun[A] =
    try {
      v
    } catch {
      case t: Throwable ⇒ raiseError(UnknownAppError(t))
    }

  def raiseError[A, E <: AppError](err: E): JobRun[A] = liftF[A](IO.raiseError[A](err))

  def pure[A](a: A) =
    ReaderT.pure[AppState, Env, A](a)

  def ask =
    ReaderT.ask[AppState, Env]

  def get = liftF(StateT.get[AppEffect, ST])

  def modify(f: ST ⇒ ST) = liftF(StateT.modify[AppEffect, ST](f))

  def evalAppRun[A](env: Env, s: ST)(f: ⇒ JobRun[A]): IO[(ST, A)] = f.run(env).run(s)

}

