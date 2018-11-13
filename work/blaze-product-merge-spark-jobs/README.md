# blaze-files-processor-spark-job

## Purpose
Streaming spark that runs in databricks that process the files once they come in transient zone
Will read an input topic containing file events from S3 and depending on the file path will either copy or encrypt it and then send it to raw

