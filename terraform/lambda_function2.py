import json
import boto3


def lambda_handler(event, context):
    dynamodb_client = boto3.resource("dynamodb")
    validation_table = dynamodb_client.Table("ValidationRequests")

    image_name = event["queryStringParameters"]["imageName"]

    response = validation_table.get_item(Key={"FileName": image_name})

    return {"statusCode": 200, "body": json.dumps(response["Item"])}
