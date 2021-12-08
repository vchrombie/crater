FROM php:7.4-fpm

# Set working directory
WORKDIR /var/www

# Copy php configurations
COPY ./docker-compose/php/uploads.ini /usr/local/etc/php/conf.d/uploads.ini

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libmagickwand-dev \
    mariadb-client

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pecl install imagick \
    && docker-php-ext-enable imagick

# Install PHP extensions
RUN rmdir html
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN useradd -G www-data,root -u 1000 -d /home/crater crater
RUN chmod 777 /var/www/ && chown 1000:1000 /var/www/

USER 0

COPY ./docker-compose/startup.sh /startup.sh

CMD ["/startup.sh"]
