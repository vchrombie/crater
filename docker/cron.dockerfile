FROM php:7.4-fpm-alpine

RUN apk add --no-cache \
    php7-bcmath

RUN docker-php-ext-install pdo pdo_mysql bcmath

COPY /docker/crontab /etc/crontabs/root

CMD ["crond", "-f"]
