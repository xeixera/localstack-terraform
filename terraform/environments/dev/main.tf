#s3 module
module "s3" {
  source      = "../../modules/s3"
  bucket-name = local.bucket-name
  s3-arn      = module.s3.bucket-arn
}


#iam module
module "iam" {
  source           = "../../modules/iam"
  iam-user         = local.environment
  sqs-arn          = module.sqs.sqs-arn["main"]
  s3-arn           = module.s3.s3-arn
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
module "lambda-worker" {
  source             = "../../modules/lambda-worker"
  sqs-arn            = module.sqs.sqs-arn["main"]
  lambda-worker-arn  = module.iam.lambda-role-arn
  lambda-worker-name = local.lambda-worker-name
  tablename-dynamodb = module.dynamodb.tablename-dynamodb
  depends_on = [
    module.iam
  ]

}

module "lambda-api" {
  source              = "../../modules/lambda-api"
  url-sqs             = module.sqs.url-sqs["main"]
  lambda-api-role-arn = module.iam.api-lambda-role-arn
  lambda-api-name     = "${local.environment}-lambda-api"
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