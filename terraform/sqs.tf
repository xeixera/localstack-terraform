resource "aws_sqs_queue" "ifocus-sqs" {
  name = var.nome-fila-sqs

  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600
}