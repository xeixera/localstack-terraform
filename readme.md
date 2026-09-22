# Subindo infraestrutura AWS de forma automática simulada com Terraform + Localstack

```bash
#instalando awscli
sudo apt install awscli -y

#instalando terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update && sudo apt-get install -y terraform

#teste com
terraform --version
```
# Configurar usuário para uso simplificado na awscli
```bash
aws configure --profile localstack

AWS Access Key ID: root
AWS Secret Access Key: root
Default region name: us-east-1
Default output format: json
```

# Chave Localstack (Hobby-Pro)
Adicionar chave do localstack no arquivo _.env_, caso não possua chave basta ir no site oficial do localstack e obter
uma chave do tipo Hobby de maneira gratuita, clicando [aqui](https://app.localstack.cloud/getting-started)

# Clonar o repositório e utilizar o terraform + localstack
```bash
git clone https://github.com/xeixera/localstack-terraform.git
cd ./localstack-ifocus

#iniciar localstack
docker compose up -d
cd ./terraform

#iniciando infraestrutura
terraform fmt && terraform validate && terraform plan
terraform apply
```

# Testar serviços
```bash
#buckets s3
aws --profile localstack --endpoint-url http://localhost:4566 s3 ls
aws --profile localstack --endpoint-url http://localhost:4566 s3 cp something.txt s3://ifocus-bucket/

#iam
aws --profile localstack --endpoint-url http://localhost:4566 iam list-users
aws --profile localstack --endpoint-url http://localhost:4566 iam list-roles
aws --profile localstack --endpoint-url http://localhost:4566 iam get-role-policy --role-name ifocus-lambda-role --policy-name ifocus-lambda-policy

#fila sqs
aws --profile localstack --endpoint-url http://localhost:4566 sqs list-queues

#dynamodb
aws --profile localstack --endpoint-url http://localhost:4566 dynamodb list-tables

#função lambda
aws --profile localstack --endpoint-url http://localhost:4566 lambda list-functions
```

# SQS e comunicação com o Banco via Lambda
```bash
#url do sqs
aws --profile localstack --endpoint-url http://localhost:4566 sqs get-queue-url --queue-name ifocus-sqs


#envio de mensagem teste
aws --profile localstack --endpoint-url http://localhost:4566 sqs send-message \
  --queue-url http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/ifocus-sqs \
  --message-body '{"teste":"hello mundo!","origem":"terraform"}'

#processamento no lambda
aws --profile localstack --endpoint-url http://localhost:4566 \
  sqs get-queue-attributes \
  --queue-url http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/ifocus-sqs \
  --attribute-names ApproximateNumberOfMessages

#visualizar no dynamodb
aws --profile localstack --endpoint-url http://localhost:4566 dynamodb scan --table-name ifocus-db-1
```