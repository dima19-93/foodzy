FROM nginx:latest

# Аргументи для сертифікатів
ARG FULLCHAIN_PEM_b64
ARG PRIVKEY_PEM_b64

# Створення директорії для SSL
RUN mkdir -p /etc/nginx/ssl && \
    printf "%s" "$FULLCHAIN_PEM_b64" | base64 -d > /etc/nginx/ssl/fullchain.pem && \
    printf "%s" "$PRIVKEY_PEM_b64" | base64 -d > /etc/nginx/ssl/privkey.pem
RUN openssl x509 -in /etc/nginx/ssl/fullchain.pem -text -noout || (echo "Invalid fullchain.pem" && exit 1)
RUN openssl rsa -in /etc/nginx/ssl/privkey.pem -check || (echo "Invalid privkey.pem" && exit 1)


#Копіювання index.html
COPY index.html /usr/share/nginx/html

# Скопируйте конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Запустите Nginx
CMD ["nginx", "-g", "daemon off;"]

