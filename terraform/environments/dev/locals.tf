locals {
  project     = "xeixera"
  environment = "dev"

  bucket-name        = "${local.project}-${local.environment}-s3"
  sqs-queue-name     = "${local.project}-${local.environment}-sqs"
  dynamodb-name      = "${local.project}-${local.environment}-dynamodb"
  lambda-worker-name = "${local.environment}-lambda-worker"
  lambda-api-name    = "${local.environment}-lambda-api"

  bucket-s3-policy = "${local.environment}-s3-policy"
  lambda-policy    = "${local.environment}-lambda-policy"
  lambda-role      = "${local.environment}-lambda-role"
  queues = {
    main = "${local.project}-${local.environment}-sqs-main"
    test = "${local.project}-${local.environment}-sqs-test"
  }
}