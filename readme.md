# Deploying AWS infrastructure automatically simulated with Terraform + Localstack

```bash
#installing awscli
sudo apt install awscli -y

#installing terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

wget -O- https://hashicorp.com | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://hashicorp.com \$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update && sudo apt-get install -y terraform

#test with
terraform --version
```

# Configure user for simplified use with awscli
```bash
aws configure --profile localstack

AWS Access Key ID: root
AWS Secret Access Key: root
Default region name: us-east-1
Default output format: json
```

# Localstack Key (Hobby-Pro)
Add the localstack key into the _.env_ file. If you don't have a key, just go to the official localstack website and get a Hobby tier key for free by clicking [here](https://localstack.cloud)

# Clone the repository and use terraform + localstack
```bash
git clone https://github.com
cd ./localstack-ifocus

#start localstack
docker compose up -d
cd ./terraform

#starting infrastructure
terraform fmt && terraform validate && terraform plan
terraform apply
```

# Also see (shellscripts)
The project includes temporarily two shell scripts to automate the deployment and destruction lifecycle across both **Dev** and **Prod** environments. Before running them, grant execution permissions:

### 1. Deploy Infrastructure (`apply.sh`)
This script automates the validation, planning, and deployment for both environments sequentially. At the end, it queries the local simulated AWS services to guarantee successful device creation.

### 2. Destroy Infrastructure (`destroy.sh`)
This script safely tears down all created resources in both environments using automated approval flags.

```bash
#grant execution perms
chmod 700 apply.sh destroy.sh

#run apply to initiate de project
./apply.sh

#run destroy to... destroy everthying xD
./destroy.sh
```

# Test services
```bash
#s3 buckets
aws --profile localstack --endpoint-url http://localhost:4566 s3 ls
aws --profile localstack --endpoint-url http://localhost:4566 s3 cp something.txt s3://ifocus-bucket/

#iam
aws --profile localstack --endpoint-url http://localhost:4566 iam list-users
aws --profile localstack --endpoint-url http://localhost:4566 iam list-roles
aws --profile localstack --endpoint-url http://localhost:4566 iam get-role-policy --role-name ifocus-lambda-role --policy-name ifocus-lambda-policy

#sqs queue
aws --profile localstack --endpoint-url http://localhost:4566 sqs list-queues

#dynamodb
aws --profile localstack --endpoint-url http://localhost:4566 dynamodb list-tables

#lambda function
aws --profile localstack --endpoint-url http://localhost:4566 lambda list-functions
```

# SQS and Database communication via Lambda
```bash
#sqs url
aws --profile localstack --endpoint-url http://localhost:4566 sqs get-queue-url --queue-name ifocus-sqs


#send test message
aws --profile localstack --endpoint-url http://localhost:4566 sqs send-message \
  --queue-url http://localstack.cloud \
  --message-body '{"test":"hello world!","origin":"terraform"}'

#lambda processing
aws --profile localstack --endpoint-url http://localhost:4566 \
  sqs get-queue-attributes \
  --queue-url http://localstack.cloud \
  --attribute-names ApproximateNumberOfMessages

#view in dynamodb
aws --profile localstack --endpoint-url http://localhost:4566 dynamodb scan --table-name ifocus-db-1
```
