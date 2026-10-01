#!/bin/bash

export AWS_ENDPOINT_URL="http://localhost:4566"
export AWS_ACCESS_KEY_ID="test"
export AWS_SECRET_ACCESS_KEY="test"
export AWS_DEFAULT_REGION="ap-southeast-1"

aws --endpoint-url "$AWS_ENDPOINT_URL" s3api create-bucket --bucket tfstate
aws --endpoint-url "$AWS_ENDPOINT_URL" dynamodb create-table \
  --table-name tflock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
