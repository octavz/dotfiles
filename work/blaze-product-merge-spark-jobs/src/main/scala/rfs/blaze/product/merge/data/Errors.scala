package rfs.blaze.product.merge.data

sealed trait AppError extends Throwable {
  val inner: Throwable = this
  val message: String = inner.getMessage

  override def getMessage = s"$message\n${super.getMessage}"

}

case class ReadJsonError(override val message: String) extends AppError

case class UnknownAppError(override val inner: Throwable) extends AppError {
  override val message = inner.getMessage
}

sealed trait FileOpsError extends AppError

case class ErrorFileNotFound(fileName: String) extends FileOpsError {
  override val message = s"$fileName not found"
}

case class ErrorDecodingPublicKey(
  override val inner: Throwable,
  override val message: String = "Error decoding public key."
) extends FileOpsError

case class ErrorEncryptingFile(override val message: String) extends FileOpsError

case class ErrorWritingEncryptedData(override val message: String) extends FileOpsError

case class ErrorGenericIO(override val inner: Throwable, error: String, fileName: String) extends FileOpsError {
  override val message = s"${fileName.mkString(",")}: IO error at: $error"
}
