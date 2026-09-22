variable "sqs-queue-name" {
  description = "sqs name"
  type        = string
}

variable "queues" {
  type = map(string)
}