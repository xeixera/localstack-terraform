provider "aws" {
  region = "us-east-1"

  access_key = "test"
  secret_key = "test"

  s3_use_path_style = true

  endpoints {
    s3        = "http://localhost:4566"
    s3control = "http://localhost:4566"
    iam       = "http://localhost:4566"
    dynamodb  = "http://localhost:4566"
    sts       = "http://localhost:4566"
    sqs       = "http://localhost:4566"
  }
}   