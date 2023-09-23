#!/usr/bin/env bash
aws lambda create-function --region us-east-1 --function-name minpack-lmdif --package-type Image --code ImageUri=860311922912.dkr.ecr.us-east-1.amazonaws.com/pfun-minpack:latest --role "arn:aws:iam::860311922912:role/pfun-minpack-lambda-role"
