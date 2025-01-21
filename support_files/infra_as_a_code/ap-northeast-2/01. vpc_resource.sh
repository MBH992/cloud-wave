#!/bin/bash

# variable
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
BUCKET_NAME="lab-edu-bucket-cf-repository-$ACCOUNT_ID"
FILE_NAME="./01. vpc_resource.yaml"
OBJ_NAME="network-baseline.yaml"
OBJ_URL="https://$BUCKET_NAME.s3.amazonaws.com/$OBJ_NAME"

# create bucket
echo "Creating S3 bucket: $BUCKET_NAME..."
if aws s3 mb s3://$BUCKET_NAME 2>/dev/null; then
    echo "Bucket created successfully."
else
    echo "Bucket already exists or creation failed."
fi

# file check
if [ ! -f "$FILE_NAME" ]; then
    echo "Error: File '$FILE_NAME' not found!"
    exit 1
fi

# data upload
echo "Uploading '$FILE_NAME' to s3://$BUCKET_NAME/$OBJ_NAME..."
if aws s3 cp "$FILE_NAME" s3://$BUCKET_NAME/$OBJ_NAME; then
    echo "File uploaded successfully."
    echo "OBJECT_URL: $OBJ_URL"
else
    echo "Error: Failed to upload file."
    exit 1
fi