package rfs.blaze
package files.processor
package helpers

import java.util.Properties
import java.net.InetSocketAddress
import java.util.concurrent.{Future ⇒ JavaFuture}

import _root_.kafka.admin.AdminUtils
import _root_.kafka.utils.ZkUtils

import org.I0Itec.zkclient.ZkConnection

import scala.concurrent._
import scala.util.Try

import scala.concurrent.ExecutionContext.Implicits.global

import cats.Comonad
import cats.implicits._
import cats.effect.IO

import rfs.blaze.it._
import rfs.blaze.it.env._
import data._

object Implicits {

  implicit class ExtractAddressAsString(env: Environment) {

    def kafkaId = env.findByType(Services.KafkaWithZookeeper).head.service.id

    def zookeeper(kafkaId: Id): InetSocketAddress = env.findById(s"zk-$kafkaId").head.address

    def kafka(): InetSocketAddress = env.findById(kafkaId).head.address

    def address(id: Id): InetSocketAddress = env.findById(id).head.address

    def addressAsString(a: InetSocketAddress): String = s"${a.getHostName}:${a.getPort}"

    def addressAsString(id: Id): String = addressAsString(address(id))

    def newTopic(topic: String): Unit = {
      val (replicationFactor, numPartitions, sessionTimeoutMs, connectionTimeoutMs) = (1, 1, 10 * 100, 8 * 100)
      val zkAddress = zookeeper(kafkaId)
      val zkClient = ZkUtils.createZkClient(addressAsString(zkAddress), sessionTimeoutMs, connectionTimeoutMs)
      val zkUtils = new ZkUtils(zkClient, zkConnection = new ZkConnection(addressAsString(zkAddress)), isSecure = false)
      AdminUtils.createTopic(zkUtils, topic, numPartitions, replicationFactor, new Properties)
      zkUtils.close()
    }
  }

  implicit def futureConverter[T](javaFuture: JavaFuture[T]): Future[T] = {
    val p = Promise[T]
    Future(p.complete(Try(javaFuture.get)))
    p.future
  }

  abstract class monadComonad[M[_]: cats.Monad] extends Comonad[M] {
    override def coflatMap[A, B](fa: M[A])(f: M[A] ⇒ B): M[B] = cats.Monad[M].pure(f(fa))

    override def map[A, B](fa: M[A])(f: A ⇒ B) = cats.Functor[M].map(fa)(f)
  }

  implicit val ioComonadInstance1: Comonad[IO] = new monadComonad[IO] {
    override def extract[A](x: IO[A]) = x.unsafeRunSync()
  }

  implicit val futureComonadInstance: Comonad[Future] = new monadComonad[scala.concurrent.Future] {
    override def extract[A](x: Future[A]) = Await.result(x, scala.concurrent.duration.Duration.Inf)
  }

  def evalAppRunGet[A](env: Env, s: ST = ST())(f: ⇒ JobRun[A]): (ST, A) = evalAppRun(env, s)(f).unsafeRunSync()
}

