#!/bin/bash
docker pull hanumith/prodcaptone:latest
docker run -d -p 80:80 hanumith/prodcapstone:latest
