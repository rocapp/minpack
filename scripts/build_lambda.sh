#!/usr/bin/env bash

docker build -t rocapp/minpack . --file lambda.dockerfile
echo '...built'

docker container create rocapp/minpack
echo '...created'

docker run --name minpack rocapp/minpack
echo '...ran'
