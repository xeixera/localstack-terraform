output "url-sqs" {
  description = "URL da fila SQS"
  value       = aws_sqs_queue.ifocus-sqs.url
}

output "arn" {
  description = "ARN da fila SQS"
  value       = aws_sqs_queue.ifocus-sqs.arn
}
