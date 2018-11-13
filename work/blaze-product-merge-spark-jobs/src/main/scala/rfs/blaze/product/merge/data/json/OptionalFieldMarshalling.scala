package rfs.blaze.product.merge.data.json

import spray.json._
import DefaultJsonProtocol._

trait OptionalFieldMarshalling {
  implicit class OptionalFieldsHelper[T: JsonFormat](map: Map[String, Option[T]]) {
    def availableFieldsToJson: Map[String, JsValue] = map
      .filter { case (key, value) ⇒ value.nonEmpty }
      .map { case (key, value) ⇒ (key, value.toJson) }
  }
}
