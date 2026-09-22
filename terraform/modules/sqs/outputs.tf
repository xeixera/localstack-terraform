output "url-sqs" {
  description = "urls from sqs queues"

  value = {
    for key, queue in aws_sqs_queue.queue-sqs : key => queue.url
  }
}

output "sqs-arn" {
  description = "arns from sqs"
  value = {
    for key, queue in aws_sqs_queue.queue-sqs : key => queue.arn
  }
}

