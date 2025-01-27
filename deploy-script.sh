
#!/bin/bash

# Логин в DockerHub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Сборка и пуш Docker-образа
docker build -t $DOCKER_USERNAME/foodzy:latest .
docker push $DOCKER_USERNAME/foodzy:latest

# Деплой на сервер
ssh -tt -o StrictHostKeyChecking=no -i id_rsa adminserver@$SERVER_IP << 'EOF'
  docker pull $DOCKER_USERNAME/foodzy:latest
  docker stop new-apples || true
  docker rm new-apples || true
  docker run -d --name new-apples -p 80:80 -p 443:443 -v /diplom_work/ssl:/etc/ssl -v /diplom_work/ssl/fullchain.pem:/etc/ssl/certs/fullchain.pem $DOCKER_USERNAME/foodzy:latest
EOF 
 
