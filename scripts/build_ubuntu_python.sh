#!/usr/bin/env bash

# build
docker build -t minpack_wheel_builder . --file ubuntu.dockerfile
echo '...built.'

# create
docker container create minpack_wheel_builder
echo '...created.'

# run
docker run --name minpack_wheel_builder minpack_wheel_builder
echo '...ran.'

# copy dist -> host
docker cp minpack_wheel_builder:/app/python/dist ./
echo '...copied.'

ls -l ./dist
echo -e '\n...done.'
