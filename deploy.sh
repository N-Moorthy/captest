#!/bin/bash

# Fetching the current Git branch
BRANCH_NAME=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD)}
echo "Current Git Branch: ${BRANCH_NAME}"

# Stop and remove existing containers
docker-compose down

# Docker login
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Docker Prod step
if [ "${BRANCH_NAME}" == "Prod" ]; then
    ./build.sh
    docker tag myimg hanumith/prodcapstone:v1
    docker push hanumith/prodcapstone:v1

elif [ "${BRANCH_NAME}" == "Dev" ]; then
    ./build.sh
    docker tag myimg hanumith/devcapstone:v1
    docker push hanumith/devcapstone:v1
fi
