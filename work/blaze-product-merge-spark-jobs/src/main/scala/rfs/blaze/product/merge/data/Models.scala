package rfs.blaze.product.merge.data

case class AlternateUrl(culture: String, url: String)

case class Size(code: String, label: String, isDefault: Boolean)

case class ShippingInfo(price: Int, vatCode: String, vatPercentage: Int)

case class Variant(
  price: Int,
  originalPrice: Int,
  scratchPrice: Option[Int] = None,
  size: Size,
  sizeAliases: Option[Vector[String]] = None,
  sizeCategory: Option[String] = None,
  shipping: ShippingInfo,
  vatCode: String,
  vatPercentage: Int,
  maxItemsInBasket: Option[Int] = None
)

case class Property(label: String, value: String, code: String, showOnSite: Boolean, order: Int)

object Property {

  implicit object PropertyOrdering extends Ordering[Property] {
    def compare(a: Property, b: Property) = a.order compare b.order
  }

}

case class ProductImage(fileName: String, category: String)

case class ProductVideo(url: String)

case class Resource(fileName: String, title: Option[String], contentType: String)

case class AdditionalInfo(title: String, description: String)

case class Promotion(
  description: String,
  resources: List[Resource] = List.empty,
  additionalInfo: Option[AdditionalInfo] = None,
  start: Option[String] = None,
  end: Option[String] = None
)

case class Taxonomy(id: String, navigationLabel: String, children: Option[List[Taxonomy1]])

case class Taxonomy1(id: String, navigationLabel: String, children: Option[List[Taxonomy2]])

case class Taxonomy2(id: String, navigationLabel: String, children: Option[List[Taxonomy3]])

case class Taxonomy3(id: String, navigationLabel: String, children: Option[List[Taxonomy4]])

case class Taxonomy4(id: String, navigationLabel: String, children: Option[List[Taxonomy5]])

case class Taxonomy5(id: String, navigationLabel: String, children: Option[List[Taxonomy6]])

case class Taxonomy6(id: String, navigationLabel: String, children: Option[List[Taxonomy7]])

case class Taxonomy7(id: String, navigationLabel: String)

case class Label(labelType: String, content: Option[String] = None, start: Option[String] = None, end: Option[String] = None)

case class PremiumAction(start: Option[String], end: Option[String], maxApplication: Int, minBasketValue: Int, productReferences: List[String])

case class SKUReference(productNumber: String, sizeCode: String)

case class Family(id: String, distinctiveProperties: List[String], memberReferences: List[String])

case class AffiliateProperty(primaryId: String, properties: List[ProgramProperty])

case class ProgramProperty(label: String, value: String)

case class Details(
  productNumber: String,
  productType: String = "REGULAR",
  sizeTableId: Option[String] = None,
  title: String,
  normalizedName: String,
  ean: Option[String] = None,
  description: Option[String] = None,
  variants: List[Variant] = List.empty,
  properties: List[Property] = List.empty,
  images: List[ProductImage] = List.empty,
  videos: Option[List[ProductVideo]] = None,
  packageContents: Option[String] = None,
  additionalInformation: Option[String] = None,
  published: Boolean = true,
  alternateUrls: List[AlternateUrl] = List.empty,
  promotions: List[Promotion] = List.empty,
  labels: List[Label] = List.empty,
  taxonomy: List[Taxonomy] = List.empty,
  searchRelevanceIndex: Option[Int] = None,
  family: Option[Family] = None,
  vasReferences: List[SKUReference] = List.empty,
  premiumActions: Option[List[PremiumAction]] = None,
  publicationDate: Option[String] = None,
  releaseDate: Option[String] = None
)
