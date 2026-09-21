resource "aws_dynamodb_table" "ifocus-bd" {
  name         = var.nome-dynamobd
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}