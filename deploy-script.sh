#! /bin/bash

docker stop new-apples || true
docker rm new-apples || true

docker pull ${{ secrets.DOCKER_USERNAME }}/foodzy:latest

docker run -d \
--name new-apples \ 
-p 80:80 \ 
-p 443:443 \ 
-v /diplom_work/ssl:/etc/ssl -v /diplom_work/ssl/fullchain.pem:/etc/ssl/certs/fullchain.pem 
${{ secrets.DOCKER_USERNAME }}/foodzy:latest
