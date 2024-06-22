#!/bin/bash
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
docker build -t myimg .
docker run --name nginx-container -d -p 3000:80  myimg
sudo apt install docker-compose -y
docker-compose up -d
docker-compose build
docker tag myimg hanumith/prodcapstone:v1
docker push hanumith/prodcapstone:v1
docker tag myimg hanumith/devcapstone:v1
docker push hanumith/devcapstone:v1
