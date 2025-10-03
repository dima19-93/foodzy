FROM nginx:latest

# Скопируйте индексный файл
COPY index.html /usr/share/nginx/html

# Создайте директорию для сертификатов в контейнере
RUN mkdir -p /etc/nginx/ssl

# Скопируйте сертификаты в контейнер
#COPY ssl/fullchain.pem /etc/nginx/ssl/fullchain.pem
#COPY ssl/privkey.pem /etc/nginx/ssl/privkey.pem
ARG FULLCHAIN_PEM
ARG PRIVKEY_PEM

RUN mkdir -p /etc/nginx/ssl && \
    echo "FULLCHAIN_PEM" > /etc/nginx/ssl/fullchain.pem && \
    echo "PRIVKEY_PEM" > /etc/nginx/ssl/privkey.pem
# Скопируйте конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Запустите Nginx
CMD ["nginx", "-g", "daemon off;"]

