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
output "LAMBDA-WORKER-NAME" {
  value = module.lambda-worker.lambda-worker-name
}

output "LAMBDA-API-NAME" {
  value = module.lambda-api.lambda-api-name
}



