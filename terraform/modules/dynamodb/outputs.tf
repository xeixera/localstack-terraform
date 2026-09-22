output "tablename-dynamodb" {
  description = "database name"
  value       = aws_dynamodb_table.dynamo-bd-1.name
}

output "arn" {
  description = "arn"
  value       = aws_dynamodb_table.dynamo-bd-1.arn
}
