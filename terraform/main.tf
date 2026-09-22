#s3 module
module "s3" {
  source = "./modules/s3"
}


#iam module
module "iam" {
  source = "./modules/iam"
}


#sqs module
module "sqs" {
  source = "./modules/sqs"
}


#lambda module
module "lambda" {
  source       = "./modules/lambda"
  sqs-arn      = module.sqs.arn
  dynamodb-arn = module.dynamodb.arn
}


#dynamodb module
module "dynamodb" {
  source = "./modules/dynamodb"
}