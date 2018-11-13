package rfs.blaze.product.merge.data.json

import rfs.blaze.product.merge.data._

import spray.json._

object KafkaDetailsMarshalling extends OptionalFieldMarshalling with SnakifiedSprayJsonSupport {

  implicit val jsonAlternateUrl      = jsonFormat2(AlternateUrl.apply)
  implicit val jsonResource          = jsonFormat3(Resource.apply)
  implicit val jsonAdditionalInfo    = jsonFormat2(AdditionalInfo)
  implicit val jsonPromotion         = jsonFormat5(Promotion.apply)
  implicit val jsonLabel             = jsonFormat4(Label.apply)
  implicit val jsonShippingInfo      = jsonFormat3(ShippingInfo)
  implicit val jsonProperty          = jsonFormat5(Property.apply)
  implicit val jsonPremiumAction     = jsonFormat5(PremiumAction.apply)
  implicit val jsonFamily            = jsonFormat3(Family.apply)
  implicit val jsonProgramProperty   = jsonFormat2(ProgramProperty.apply)
  implicit val jsonAffiliateProperty = jsonFormat2(AffiliateProperty.apply)
  implicit val jsonSize              = jsonFormat3(Size.apply)
  implicit val jsonImage             = jsonFormat2(ProductImage.apply)
  implicit val jsonVideo             = jsonFormat1(ProductVideo.apply)
  implicit val skuReferenceFormat    = jsonFormat(SKUReference.apply, "product_number", "size_code")
  implicit val jsonTax7              = jsonFormat2(Taxonomy7.apply)
  implicit val jsonTax6              = jsonFormat3(Taxonomy6.apply)
  implicit val jsonTax5              = jsonFormat3(Taxonomy5.apply)
  implicit val jsonTax4              = jsonFormat3(Taxonomy4.apply)
  implicit val jsonTax3              = jsonFormat3(Taxonomy3.apply)
  implicit val jsonTax2              = jsonFormat3(Taxonomy2.apply)
  implicit val jsonTax1              = jsonFormat3(Taxonomy1.apply)
  implicit val jsonTax               = jsonFormat3(Taxonomy.apply)

  implicit object VariantFormat extends RootJsonFormat[Variant] {
    def write(variant: Variant) = {
      val optionalIntFields = Map("scratch_price" → variant.scratchPrice, "max_items_in_basket" → variant.maxItemsInBasket).availableFieldsToJson

      val size = {
        val s = variant.size.toJson.asJsObject
        val aliases = variant.sizeAliases.map(aliases ⇒ Map("aliases" → aliases.toJson)).getOrElse(Map.empty)
        val category = variant.sizeCategory.map(category ⇒ Map("category" → category.toJson)).getOrElse(Map.empty)
        JsObject(s.fields ++ aliases ++ category)
      }

      val fields = Map(
        "price" → variant.price.toJson,
        "original_price" → variant.originalPrice.toJson,
        "scratch_price" → variant.scratchPrice.toJson,
        "size" → size,
        "shipping" → variant.shipping.toJson,
        "vat_code" → variant.vatCode.toJson,
        "vat_percentage" → variant.vatPercentage.toJson
      ) ++ optionalIntFields

      JsObject(fields)
    }

    def read(value: JsValue) = {
      val fields = value.asJsObject.fields
      Variant(
        price = fields("price").convertTo[Int],
        originalPrice = fields("original_price").convertTo[Int],
        scratchPrice = fields.get("scratch_price").filterNot(_ == JsNull).map(_.convertTo[Int]),
        size = fields("size").convertTo[Size],
        sizeAliases = fields("size").asJsObject.fields.get("aliases").map(_.convertTo[Vector[String]]),
        sizeCategory = fields("size").asJsObject.fields.get("category").map(_.convertTo[String]),
        shipping = fields("shipping").convertTo[ShippingInfo],
        vatCode = fields("vat_code").convertTo[String],
        vatPercentage = fields("vat_percentage").convertTo[Int],
        maxItemsInBasket = fields.get("max_items_in_basket").map(_.convertTo[Int])
      )
    }
  }


  implicit object DetailFormat extends RootJsonFormat[Details] {
    def write(details: Details) = {
      val optionalStringFields = Map("description" → details.description, "size_table_id" → details.sizeTableId).availableFieldsToJson

      val optionalIntFields = Map("search_relevance_index" → details.searchRelevanceIndex).availableFieldsToJson
      val optionalPremiumActions = Map("premium_actions" → details.premiumActions).availableFieldsToJson

      val optionalFamilyField = Map("family" → details.family).availableFieldsToJson

      val optionalDateFields = Map(
        "publication_date" → details.publicationDate,
        "release_date" → details.releaseDate
      ).availableFieldsToJson

      val optionalVideoField = Map("videos" → details.videos).availableFieldsToJson

      val fields = Map(
        "product_number" → details.productNumber.toJson,
        "product_type" → details.productType.toJson,
        "title" → details.title.toJson,
        "ean" → details.ean.getOrElse("").toJson,
        "normalized_name" → details.normalizedName.toJson,
        "variants" → details.variants.toJson,
        "properties" → details.properties.toJson,
        "images" → details.images.toJson,
        "package_contents" → details.packageContents.getOrElse("").toJson,
        "additional_information" → details.additionalInformation.getOrElse("").toJson,
        "published" → details.published.toJson,
        "alternate_urls" → details.alternateUrls.toJson,
        "taxonomy" → details.taxonomy.toJson,
        "promotions" → details.promotions.toJson,
        "labels" → details.labels.toJson,
        "vas_references" → details.vasReferences.toJson
      ) ++ optionalStringFields ++ optionalIntFields ++ optionalFamilyField ++ optionalPremiumActions ++ optionalDateFields ++ optionalVideoField

      JsObject(fields)
    }

    def read(value: JsValue) = {
      val fields = value.asJsObject.fields

      Details(
        productNumber = fields("product_number").convertTo[String].trim,
        productType = fields("product_type").convertTo[String],
        sizeTableId = fields.get("size_table_id").map(_.convertTo[String]),
        ean = fields.get("ean").map(_.convertTo[String]).filterNot(_.isEmpty),
        title = fields("title").convertTo[String],
        normalizedName = fields("normalized_name").convertTo[String],
        description = fields.get("description").map(_.convertTo[String]),
        variants = fields("variants").convertTo[List[Variant]],
        properties = fields("properties").convertTo[List[Property]],
        images = fields("images").convertTo[List[ProductImage]],
        videos = fields.get("videos").map(_.convertTo[List[ProductVideo]]),
        packageContents = fields.get("package_contents").map(_.convertTo[String]).filterNot(_.isEmpty),
        additionalInformation = fields.get("additional_information").map(_.convertTo[String]).filterNot(_.isEmpty),
        published = fields("published").convertTo[Boolean],
        alternateUrls = fields.get("alternate_urls").map(_.convertTo[List[AlternateUrl]]).getOrElse(List.empty[AlternateUrl]),
        taxonomy = fields("taxonomy").convertTo[List[Taxonomy]],
        searchRelevanceIndex = fields.get("search_relevance_index").map(_.convertTo[Int]),
        promotions = fields("promotions").convertTo[List[Promotion]],
        labels = fields("labels").convertTo[List[Label]],
        vasReferences = fields("vas_references").convertTo[List[SKUReference]],
        premiumActions = fields.get("premium_actions").map(_.convertTo[List[PremiumAction]]),
        family = fields.get("family").map(_.convertTo[Family]),
        publicationDate = fields.get("publication_date").map(_.convertTo[String]),
        releaseDate = fields.get("release_date").map(_.convertTo[String])
      )
    }
  }

}
