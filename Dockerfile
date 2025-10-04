FROM nginx:latest

# Створюємо директорію для сертифікатів
RUN mkdir -p /etc/nginx/ssl

# Копіюємо SSL-файли, які були створені в GitHub Actions перед збіркою
COPY fullchain.pem /etc/nginx/ssl/fullchain.pem
COPY privkey.pem /etc/nginx/ssl/privkey.pem

# Копіюємо конфігурацію Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Копіюємо статичний контент (опціонально)
COPY index.html /usr/share/nginx/html/index.html

# Запускаємо Nginx
CMD ["nginx", "-g", "daemon off;"] 
