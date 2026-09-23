resource "aws_iam_user" "user-iam" {
  name = var.iam-user
}

#s3 permission policy
resource "aws_iam_user_policy" "bucket-s3" {
  name = var.bucket-s3-policy
  user = aws_iam_user.user-iam.name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]

        Resource = "*"
      }
    ]
  })
}

#lambda role conf
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


#lambda role iam permission policy
resource "aws_iam_role_policy" "lambda-policy" {
  name = var.lambda-policy

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