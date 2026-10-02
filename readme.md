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
  # Project structure
  ```text
  terraform/
  ├── backend/
  ├── environments/
  │   ├── dev/
  │   └── prod/
  └── modules/
      ├── dynamodb/
      ├── iam/
      ├── lambda/
      ├── s3/
      └── sqs/
  ```

  # Environments

  The `environments` directory contains the different infrastructure environments used by the project.

  - **dev:** development and testing environment.
  - **prod:** production-like environment.

  Both environments use the same reusable Terraform modules, but maintain separate configurations and Terraform states.

  # Terraform backend
  Responsible for creating the S3 bucket used to store the Terraform state, because dev and prod use the same reusable modules while maintaining independent Terraform states.
  **The backend must be created before initializing the environments.**

  The state bucket will be created in Localstack after run backend init:
  ```bash
    s3://s3-terraform-state/ 
    ├── dev/
    └── prod/
  ```
  
  # Localstack Key (Hobby-Pro)
  Add the localstack key into the _.env_ file. If you don't have a key, just go to the official localstack website and get a Hobby tier key for free by clicking [here](https://localstack.cloud)

  # Clone the repository and use terraform + localstack
  ```bash
  git clone https://github.com/xeixera/localstack-terraform.git

  #manually config
  cd ./localstack-ifocus

  #start localstack
  docker compose up -d

  #running bucket for .tfstates
  cd ./terraform/backend
  terraform init && terraform apply

  #starting infrastructure (do the same for both environments)
  cd ../environments/dev
  terraform init && terraform terraform apply

  ```

  # Also see (shellscripts for easy development)
  The project includes temporarily two shell scripts to automate the apply and destruction lifecycle across both **Dev** and **Prod** environments. Before running them, grant execution permissions.

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


  # GitHub Actions
  The project also uses GitHub Actions to automatically validate the Terraform configuration in a clean environment, with the workflow at
  ```localstack-tf/.github/workflows/localstack-tf.yml```

  ```bash
  git push -> GitHub Actions -> Checkout -> Setup Terraform -> Start Localstack -> Check Localstack ->
  terraform fmt -check -> terraform validate -> terraform plan
  ```
  The Localstack container is started using the same docker-compose.yml used locally, and the **LOCALSTACK_AUTH_TOKEN must be configured as a GitHub Actions repository secret**.

  This Terraform workflow and project uses simple LocalStack credentials for lab purposes only. Never store your real keys in files like this.
 ```bash
  AWS_ACCESS_KEY_ID: root
  AWS_SECRET_ACCESS_KEY: root
  AWS_DEFAULT_REGION: us-east-1
 ```
  These are not real AWS credentials and are only used to communicate with Localstack.

  The CI/CD pipeline is being incrementally expanded to automate the Terraform deployment lifecycle.

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
