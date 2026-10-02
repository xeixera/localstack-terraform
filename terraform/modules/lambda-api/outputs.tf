output "lambda-api-name" {
  value       = aws_lambda_function.lambda-api.function_name
}

output "lambda-api-arn" {
  value       = aws_lambda_function.lambda-api.arn
}