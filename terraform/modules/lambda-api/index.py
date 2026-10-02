import json
import boto3
import os

sqs = boto3.client("sqs")

QUEUE_URL = os.environ.get("QUEUE_URL")


def lambda_handler(event, context):

    print(f"Got this event: {event}")

    message = {
        "message": "Sooooooo niceeee!",
        "source": "lambda-api"
    }

    response = sqs.send_message(
        QueueUrl=QUEUE_URL,
        MessageBody=json.dumps(message)
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Message sent to SQS!",
            "message_id": response["MessageId"]
        })
    }