resource "aws_iam_role" "lambda-role" {
  name = var.lambda-role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda-policy" {
  name = "ifocus-lambda-policy"
  role = aws_iam_role.lambda-role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]

        Resource = var.sqs-arn
      },

      {
        Effect = "Allow"

        Action = [
          "dynamodb:PutItem"
        ]

        Resource = var.dynamodb-arn
      }
    ]
  })
}

resource "aws_lambda_function" "lambda-exec" {
  function_name    = "running-lambda"
  source_code_hash = filebase64sha256("${path.module}/func-lambda.zip")

  filename = "${path.module}/func-lambda.zip"

  handler = "index.lambda_handler"
  runtime = "python3.12"

  role = aws_iam_role.lambda-role.arn
}

resource "aws_lambda_event_source_mapping" "sqs-lambda" {
  event_source_arn = var.sqs-arn
  function_name    = aws_lambda_function.lambda-exec.arn

  batch_size = 1
}