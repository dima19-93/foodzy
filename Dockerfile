FROM nginx:latest

# Аргументи для сертифікатів
ARG FULLCHAIN_PEM
ARG PRIVKEY_PEM

# Створення директорії для SSL
RUN mkdir -p /etc/nginx/ssl && \
    printf "$FULLCHAIN_PEM" > /etc/nginx/ssl/fullchain.pem && \
    printf "$PRIVKEY_PEM" > /etc/nginx/ssl/privkey.pem && \
    head -n 1 /etc/nginx/ssl/fullchain.pem && \
    head -n 1 /etc/nginx/ssl/privkey.pem

RUN test -s /etc/nginx/ssl/fullchain.pem || (echo "fullchain.pem is empty!" && exit 1) && \
    test -s /etc/nginx/ssl/privkey.pem || (echo "privkey.pem is empty!" && exit 1)


#Копіювання index.html
COPY index.html /usr/share/nginx/html

# Скопируйте конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Запустите Nginx
CMD ["nginx", "-g", "daemon off;"]

