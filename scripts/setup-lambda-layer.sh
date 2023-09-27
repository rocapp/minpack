#!/usr/bin/env bash

aws lambda create-function \
    --region us-east-1 \
    --function-name minpack-lmdif \
    --package-type Image \
    --code ImageUri=$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/pfun-minpack:latest \
    --role "arn:aws:iam::$AWS_ACCOUNT_ID:role/pfun-minpack-lambda-role" ||
    aws lambda update-function-code \
	--region us-east-1 \
	--function-name minpack-lmdif \
	--image-uri $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/pfun-minpack:latest
