resource "aws_lambda_function" "lambda-api" {
  function_name    = var.lambda-api-name
  source_code_hash = filebase64sha256("${path.module}/func-lambda-api.zip")

  filename = "${path.module}/func-lambda-api.zip"

  handler = "index.lambda_handler"
  runtime = "python3.12"

  role = var.lambda-api-role-arn

  environment {
    variables = {
      QUEUE_URL = var.url-sqs
    }
  }
}