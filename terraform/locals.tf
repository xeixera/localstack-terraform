locals {
  project = "xeixera"

  bucket-name    = "${local.project}-s3-bucket-1"
  sqs-queue-name = "${local.project}-sqs-queue-1"
  dynamodb-name  = "${local.project}-dynamodb-1"


  queues = {
    main = "ifocus-sqs"
    test = "ifocus-sqs-test"
  }
}