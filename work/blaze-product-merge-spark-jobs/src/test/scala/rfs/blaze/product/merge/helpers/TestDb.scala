package rfs.blaze
package product.merge
package helpers

import swaydb._
import java.nio.file.Paths

import swaydb.serializers.Default._

object TestDb {

  val random = java.util.UUID.randomUUID().toString
  val rootDBDir = Paths.get(this.getClass.getResource("").getPath).getParent.getParent.resolve(s"testDB-$random")
  val db = SwayDB.persistent[String, String](dir = rootDBDir.resolve("disk1"), otherDirs = Seq(rootDBDir.resolve("disk2"))).get

  def apply() = db

  def inc(key: String): Unit = {
    val newVal = db.get(key).get.fold(1)(_.toInt + 1)
    db.put(key, newVal.toString).get
    ()
  }

  def getInt(key: String): Option[Int] = db.get(key).get.map(_.toInt)

  def clean(): Unit = {
    println(s"*********DB clean**********")
    val keys = db.keys.toList
    if (keys.nonEmpty) db.batchRemove(db.keys).get
    ()
  }

  def dump(): Unit = {
    println(s"*********DB Dump**********")
    db.keys.foreach(k ⇒ println(s"$k -> ${db.get(k).get.get}"))
    println(s"*********END**********")
  }

}
