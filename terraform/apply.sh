#!/bin/bash
set -e

error() {
    echo -e "\n\e[1;36m[Errors has been encoutered during 'terraform apply']\e[0m\n"
}
trap error ERR


echo -e "\e[1;36m[Running Dev Enviroment]\e[0m\n"
cd ./environments/dev
terraform validate && terraform plan
terraform apply -auto-approve


echo -e "\n\e[1;36m[Running Prod Enviroment]\e[0m\n"
cd ../prod
terraform validate && terraform plan && sleep 5
terraform apply -auto-approve


echo -e "\n\n\e[1;36m[Success creating the devices!]\e[0m\n"

echo -e "\n\e[1;36m[s3]\e[0m"
aws --profile localstack --endpoint-url=http://localhost:4566 s3api list-buckets \
  --query 'Buckets[].Name' --output table

echo -e "\n\e[1;36m[sqs]\e[0m"
aws --profile localstack --endpoint-url=http://localhost:4566 sqs list-queues \
  --query 'QueueUrls[]' --output table

echo -e "\n\e[1;36m[dynamodb]\e[0m"
aws --profile localstack --endpoint-url=http://localhost:4566 dynamodb list-tables \
  --query 'TableNames[]' --output table

echo -e "\n\e[1;36m[lambda]\e[0m"
aws --profile localstack --endpoint-url=http://localhost:4566 lambda list-functions \
--query 'Functions[].FunctionName' --output table

echo -e "\n\e[1;36m[iam roles]\e[0m"
aws --profile localstack --endpoint-url=http://localhost:4566 iam list-roles --query 'Roles[].RoleName' --output table
