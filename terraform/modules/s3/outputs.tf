output "bucket-name-out" {
  description = "nome do bucket criado"
  value = aws_s3_bucket.ifocus-bucket.bucket
}