#!/bin/bash
docker pull sarathakashk95/prod:latest
docker run -d -p 80:80 sarathakashk95/prod:latest
