output "BUCKET-NAME" {
  value = module.s3.bucket-name-out
}

output "IAM-USERNAME" {
  value = module.iam.iam-user-name
}

output "SQS-QUEUE-URL" {
  value = module.sqs.url-sqs
}

output "DYNAMODB-NAME" {
  value = module.dynamodb.tablename-dynamodb
}
output "LAMBDA-ROLE-NAME" {
  value = module.lambda.lambda-name
}