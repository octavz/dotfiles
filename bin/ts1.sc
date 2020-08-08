#!/usr/bin/amm
import ammonite.ops._
import ammonite.ops.ImplicitWd._
import java.time._
import scala.util._

@main
def main(from: Int = 0, many: Int = 24, debug: Boolean = false) = {
  val now = ZonedDateTime.now().plusHours(from)
  val to = now.plusHours(many)

  def genMins(m: Int, start: ZonedDateTime, acc: List[ZonedDateTime]): List[ZonedDateTime] = {
    val nd = start
      .plusMinutes(m + Random.nextInt(4))
      .withSecond(Random.nextInt(59))
    if(nd.toEpochSecond < to.toEpochSecond) genMins(m, nd, nd :: acc)
    else acc.reverse
  }

  val fmt = (d: String) => s"9,$d,01.tt,207,14589"
  val all = genMins(25, now, Nil)
    .filterNot(dt => dt.getHour > 0 && dt.getHour <5)
  val dates = all.map(_.toEpochSecond.toString).map(fmt)

  if (!debug) print(dates.mkString("|"))
  else all.foreach(println)
}
