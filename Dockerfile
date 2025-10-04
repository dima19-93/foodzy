FROM nginx:latest

# Аргументи для сертифікатів
ARG FULLCHAIN_PEM_B64
ARG PRIVKEY_PEM_B64

RUN mkdir -p /etc/nginx/ssl 

# Копіювання SSL-файлів
COPY fullchain.pem /etc/nginx/ssl/fullchain.pem
COPY privkey.pem /etc/nginx/ssl/privkey.pem

# Копіювання index.html
COPY index.html /usr/share/nginx/html

# Скопируйте конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Запустите Nginx
CMD ["nginx", "-g", "daemon off;"]

