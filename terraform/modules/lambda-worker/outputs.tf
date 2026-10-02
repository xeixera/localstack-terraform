output "lambda-worker-name" {
  value = aws_lambda_function.lambda-worker.function_name
}

output "lambda-worker-arn" {
  value = aws_lambda_function.lambda-worker.arn
}