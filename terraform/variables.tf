variable "nome-bucket" {
  description = "nome da var do bucket s3"
  type        = string
  default     = "ifocus-bucket"
}

variable "iam-user" {
  description = "nome da var do user iam"
  type        = string
  default     = "ifocus-user"
}

variable "nome-fila-sqs" {
  description = "nome da var de fila do sqs"
  type        = string
  default     = "fila-ifocus"
}

variable "nome-dynamobd" {
  description = "nome do dynamobd"
  type        = string
  default     = "ifocus-bd-1"
}