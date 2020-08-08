#!/usr/bin/amm
import ammonite.ops._
import ammonite.ops.ImplicitWd._
import java.time._
import scala.util._

@main
def main(
    day: Int = 0,
    from: Int = 0,
    many: Int = 23,
    debug: Boolean = false
) = {
  val now = ZonedDateTime.now()
  val gen : (Int, Int, Int) => Option[String] = (d, h, mins) => {
    val ret = now
      .plusDays(d)
      .withHour(h)
      .withMinute(mins + Random.nextInt(3))
      .withSecond(Random.nextInt(59))
      if(ret.getHour > 0 && ret.getHour < 5 ) None
      else Some(if (debug) ret.toString else ret.toEpochSecond.toString)
  }
  val trim: (Int, Int) => Option[String] = (h, extraMins) =>
    if (h > 23) gen(day + 1, h % 24, extraMins) else gen(day, h, extraMins)

  val fmt = (d: String) => s"9,$d,01.tt,207,14589"
  val dates = (from to (from + many)).flatMap { hour =>
    List(
      trim(hour, 0), 
      trim(hour, 20), 
      trim(hour, 40)
    ).collect { case Some(s) => fmt(s) }
  }
  if (!debug) println(dates.mkString("|"))
  else (dates).foreach(println)
}
