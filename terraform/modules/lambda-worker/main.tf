resource "aws_lambda_function" "lambda-worker" {
  function_name    = var.lambda-worker-name
  source_code_hash = filebase64sha256("${path.module}/func-lambda-worker.zip")

  filename = "${path.module}/func-lambda-worker.zip"

  handler = "index.lambda_handler"
  runtime = "python3.12"

  role = var.lambda-worker-arn

  environment {
    variables = {
      DYNAMODB_TABLE = var.tablename-dynamodb
    }
  }
}

resource "aws_lambda_event_source_mapping" "sqs-lambda" {
  event_source_arn = var.sqs-arn
  function_name    = aws_lambda_function.lambda-worker.arn

  batch_size = 1
}