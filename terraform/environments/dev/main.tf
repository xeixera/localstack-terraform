#s3 module
module "s3" {
  source      = "../../modules/s3"
  bucket-name = local.bucket-name
}


#iam module
module "iam" {
  source           = "../../modules/iam"
  iam-user         = local.environment
  sqs-arn          = module.sqs.sqs-arn["main"]
  dynamodb-arn     = module.dynamodb.arn
  bucket-s3-policy = local.bucket-s3-policy
  lambda-policy    = local.lambda-policy
  lambda-role      = local.lambda-role
}


#sqs module
module "sqs" {
  sqs-queue-name = local.sqs-queue-name
  source         = "../../modules/sqs"
  queues         = local.queues
}


#lambda module
module "lambda" {
  source          = "../../modules/lambda"
  sqs-arn         = module.sqs.sqs-arn["main"]
  lambda-role-arn = module.iam.lambda-role-arn
  dynamodb-arn    = module.dynamodb.arn
  lambda-exec     = local.lambda-exec

  depends_on = [
    module.iam
  ]
}


#dynamodb module
module "dynamodb" {
  source        = "../../modules/dynamodb"
  dynamodb-name = local.dynamodb-name
}

#sharing tfstate to a s3 bucket for multiaccess
terraform {
  backend "s3" {
    bucket = "s3-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"

    access_key = "root"
    secret_key = "root"
    endpoints = {
      s3 = "http://localhost:4566"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}