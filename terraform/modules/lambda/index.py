import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("ifocus-bd-1")


def lambda_handler(event, context):

    print(f"its working:{event}")

    for record in event["Records"]:

        message_id = record["messageId"]
        mensagem = record["body"]

        table.put_item(
            Item={
                "id": message_id,
                "mensagem": mensagem
            }
        )

        print(f"message send to dynamodb: {message_id}")

    return {
        "statusCode": 200,
        "body": "i really like this! nicee!"
    }