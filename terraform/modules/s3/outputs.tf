output "bucket-name-out" {
  value = aws_s3_bucket.bucket-1.bucket
}

output "bucket-arn" {
  value       = aws_s3_bucket.bucket-1.arn
}