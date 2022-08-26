import json
import boto3
from botocore.exceptions import ClientError

def snspub(event, context):
    client=boto3.resource('sns')
    topic=client.create_topic(Name='hworld')
    topic.publish(Message='bork')


