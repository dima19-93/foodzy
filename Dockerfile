FROM nginx:latest

# Аргументи для сертифікатів
ARG FULLCHAIN_PEM_b64
ARG PRIVKEY_PEM_b64

# Створення директорії для SSL
RUN mkdir -p /etc/nginx/ssl && \
    printf "%s" "$FULLCHAIN_PEM_B64" | base64 -d > /etc/nginx/ssl/fullchain.pem && \
    printf "%s" "$PRIVKEY_PEM_B64" | base64 -d > /etc/nginx/ssl/privkey.pem && \
    openssl x509 -in /etc/nginx/ssl/fullchain.pem -text -noout && \
    openssl rsa -in /etc/nginx/ssl/privkey.pem -check


#Копіювання index.html
COPY index.html /usr/share/nginx/html

# Скопируйте конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Запустите Nginx
CMD ["nginx", "-g", "daemon off;"]

