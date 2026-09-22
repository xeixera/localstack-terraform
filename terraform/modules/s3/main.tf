resource "aws_s3_bucket" "bucket-1" {
  bucket = var.bucket-name
  #lifecycle {
  #  prevent_destroy = true
  #}
}