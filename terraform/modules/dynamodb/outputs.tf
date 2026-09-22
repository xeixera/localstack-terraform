output "tablename-dynamodb" {
  description = "database name"
  value       = aws_dynamodb_table.ifocus-bd.name
}

output "arn" {
  description = "arn"
  value       = aws_dynamodb_table.ifocus-bd.arn
}
