output "iam-user-name" {
  description = "iam user name"
  value       = aws_iam_user.user1-iam.name
}

output "lambda-role-arn" {
  description = "arn from iam role used by lambda"
  value       = aws_iam_role.lambda-role.arn
}