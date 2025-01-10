FROM nginx
COPY index.html /usr/share/nginx/html
COPY /etc/letsencrypt/live/apple.foodzy.pp.ua/fullchain.pem /etc/nginx/ssl/fullchain.pem
COPY /etc/letsencrypt/live/apple.foodzy.pp.ua/privkey.pem /etc/nginx/ssl/privkey.pem
COPY nginx.conf /etc/nginx/nginx.conf
