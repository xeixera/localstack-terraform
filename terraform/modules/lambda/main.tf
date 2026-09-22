resource "aws_lambda_function" "lambda-exec" {
  function_name    = var.lambda-exec
  source_code_hash = filebase64sha256("${path.module}/func-lambda.zip")

  filename = "${path.module}/func-lambda.zip"

  handler = "index.lambda_handler"
  runtime = "python3.12"

  role = var.lambda-role-arn
}

resource "aws_lambda_event_source_mapping" "sqs-lambda" {
  event_source_arn = var.sqs-arn
  function_name    = aws_lambda_function.lambda-exec.arn

  batch_size = 1
}