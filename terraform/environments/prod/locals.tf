locals {
  project     = "xeixera"
  environment = "prod"

  bucket-name    = "${local.project}-${local.environment}-s3"
  sqs-queue-name = "${local.project}-${local.environment}-sqs"
  dynamodb-name  = "${local.project}-${local.environment}-dynamodb"
  lambda-exec    = "${local.environment}-lambda-exec"


  bucket-s3-policy = "${local.project}-s3-policy"
  lambda-policy    = "${local.project}-lambda-policy"
  lambda-role      = "${local.project}-${local.environment}-lambda-role"
  
  queues = {
    main = "${local.project}-${local.environment}-sqs-main"
    test = "${local.project}-${local.environment}-sqs-test"
  }
}