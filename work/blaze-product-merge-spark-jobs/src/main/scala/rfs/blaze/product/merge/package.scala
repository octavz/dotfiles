package rfs.blaze
package files

import java.time._
import java.util.TimeZone

package object processor {

  def fromUnixTimestamp(ts: Long): LocalDateTime =
    LocalDateTime.ofInstant(Instant.ofEpochSecond(ts), TimeZone.getTimeZone("UTC").toZoneId)

  def toUnixTimestamp(date: LocalDateTime): Long =
    date.atZone(TimeZone.getTimeZone("UTC").toZoneId).toEpochSecond

}

