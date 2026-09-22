variable "lambda-role" {
  type        = string
  default     = "ifocus-lambda-role"
}

variable "sqs-arn" {
  type = string
}

variable "dynamodb-arn" {
  type = string
}

