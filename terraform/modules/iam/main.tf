resource "aws_iam_user" "ifocus-iam" {
  name = var.iam-user
}

resource "aws_iam_user_policy" "ifocus-s3" {
  name = "ifocus-s3-policy"
  user = aws_iam_user.ifocus-iam.name

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