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

RUN printf "%b" "$FULLCHAIN_PEM" > /etc/nginx/ssl/fullchain.pem && \
    openssl x509 -in /etc/nginx/ssl/fullchain.pem -noout || (echo "❌ Сертифікат пошкоджений" && exit 1)

RUN printf "%b" "$PRIVKEY_PEM" > /etc/nginx/ssl/privkey.pem
RUN echo "🔍 FULLCHAIN_PEM content:" && printf "%b\n" "$FULLCHAIN_PEM"


# Скопируйте конфигурационный файл Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Запустите Nginx
CMD ["nginx", "-g", "daemon off;"]

