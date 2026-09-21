# baixar aws cli
sudo apt install awscli -y

# 3. Instalar Terraform
# https://developer.hashicorp.com/terraform/install

# 4. Clonar o projeto
git clone 
cd localstack-ifocus

# 5. Subir o LocalStack
docker compose up -d

# 6. Configurar AWS CLI para o LocalStack
aws configure --profile localstack

AWS Access Key ID: test
AWS Secret Access Key: test
Default region name: us-east-1
Default output format: json

Testar perfil:
aws --profile localstack --endpoint-url=http://localhost:4566 sts get-caller-identity

Testar após dar apply: serviços

aws --profile localstack --endpoint-url=http://localhost:4566 s3api list-buckets

aws --profile localstack --endpoint-url=http://localhost:4566 iam list-users

aws --profile localstack --endpoint-url=http://localhost:4566 sqs list-queues

aws --profile localstack --endpoint-url=http://localhost:4566 dynamodb list-tables