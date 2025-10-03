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

RUN echo "$FULLCHAIN_PEM" | sed 's/\\n/\n/g' > /etc/nginx/ssl/fullchain.pem && \
    openssl x509 -in /etc/nginx/ssl/fullchain.pem -noout || (echo "❌ Сертифікат пошкоджений" && exit 1)
RUN echo "$PRIVKEY_PEM" | sed 's/\\n/\n/g' > /etc/nginx/ssl/privkey.pem
# Скопируйте конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Запустите Nginx
CMD ["nginx", "-g", "daemon off;"]

