variable "sqs-arn" {
  type = string
}
variable "dynamodb-arn" {
  type = string
}

variable "s3-arn" {
  type = string
}

variable "bucket-s3-policy" {
  type = string
}

variable "iam-user" {
  type = string
}

variable "lambda-policy" {
  type = string
}

variable "lambda-role" {
  type = string
}