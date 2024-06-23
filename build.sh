#!/bin/bash

#Docker image build step
docker build -t myimg .

#Docker compose file for container
docker-compose up -d 
