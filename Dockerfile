# IMAGE DE DEPART 
# image start for laravel application
FROM php

# INSTAL OTHER DEPENDENCIES
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip
# INSTALL COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# ENABLE pdo_mysql and pdo_pgsql in php.ini
RUN docker-php-ext-install pdo_mysql mbstring
# SPECIFY THE WORKING DIRECTORY
WORKDIR /application
# COPY THE COMPOSER.JSON FILE
COPY ./composer.json .
# RUN COMPOSER INSTALL
RUN composer install --no-scripts
# COPY ALL THE FILE
COPY . .
# RUN COMMAND PHP ARTISAN on host and port 80
CMD php artisan serve --host=0.0.0.0 --port=80
