output "lambda-name" {
  description = "func lambda name"
  value       = aws_lambda_function.lambda-exec.function_name
}