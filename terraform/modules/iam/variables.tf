variable "iam-user" {
  description = "iam user"
  type        = string
  default     = "ifocus-user"
}
variable "sqs-arn" {
  type = string
}
variable "dynamodb-arn" {
  type = string
}