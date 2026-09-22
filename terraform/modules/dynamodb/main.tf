resource "aws_dynamodb_table" "dynamo-bd-1" {
  name         = var.dynamodb-name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
  lifecycle {
    create_before_destroy = true
  }
}
