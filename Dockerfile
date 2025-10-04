FROM nginx:latest

# Аргументи для сертифікатів
ARG FULLCHAIN_PEM
ARG PRIVKEY_PEM

# Створення директорії для SSL
RUN mkdir -p /etc/nginx/ssl && \
    printf "%s" "$FULLCHAIN_PEM" > /etc/nginx/ssl/fullchain.pem && \
    printf "%s" "$PRIVKEY_PEM" > /etc/nginx/ssl/privkey.pem


#Копіювання index.html
COPY index.html /usr/share/nginx/html

# Скопируйте конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Запустите Nginx
CMD ["nginx", "-g", "daemon off;"]

