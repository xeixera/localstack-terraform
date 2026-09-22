resource "aws_sqs_queue" "queue-sqs" {
  
  for_each = var.queues
  name = each.value

  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600
}