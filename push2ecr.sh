#!/usr/bin/env bash

set -e

AWS_ACCOUNT_ID=860311922912
REPO_URI=${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/pfun-minpack

# login
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "${REPO_URI}" || exit 1
sleep 1s

# push
docker tag rocapp/minpack:latest "${REPO_URI}:latest"
docker push "${REPO_URI}:latest"
