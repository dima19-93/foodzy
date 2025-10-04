FROM nginx:latest

# Аргументи для сертифікатів
ARG FULLCHAIN_PEM
ARG PRIVKEY_PEM

# Створення директорії для SSL
RUN mkdir -p /etc/nginx/ssl

# Запис сертифікатів у файли
RUN echo -e "$FULLCHAIN_PEM" > /etc/nginx/ssl/fullchain.pem
    echo -e "$PRIVKEY_PEM" > /etc/nginx/ssl/privkey.pem

#Копіювання index.html
COPY index.html /usr/share/nginx/html

# Скопируйте конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Запустите Nginx
CMD ["nginx", "-g", "daemon off;"]

