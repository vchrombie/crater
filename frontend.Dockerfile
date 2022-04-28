FROM nginx:1.17-alpine

COPY docker-compose/nginx /etc/nginx/conf.d/
RUN rm /etc/nginx/conf.d/default.conf
COPY public/ /var/www/public/