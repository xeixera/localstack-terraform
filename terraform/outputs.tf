output "nome-bucket" {
  description = "nome do bucket criado"
  value       = aws_s3_bucket.ifocus-bucket.bucket
}

output "nome-usuario-iam" {
  description = "nome do user IAM criado"
  value       = aws_iam_user.ifocus-iam.name
}

#estudar esse mecanismo de fila sqs
output "url-fila-sqs" {
  description = "url da fila SQS"
  value       = aws_sqs_queue.ifocus-sqs.url
}

output "nome-tabela-banco" {
  description = "nome da tabela dynamoDB"
  value       = aws_dynamodb_table.ifocus-bd.name
}