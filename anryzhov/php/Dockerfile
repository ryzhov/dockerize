# ./docker/php/Dockerfile
FROM php:7.2-fpm

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
COPY config/symfony.ini $PHP_INI_DIR/conf.d/

RUN set -xe; \
    apt-get update; \
    apt-get install -y --no-install-recommends libxml2-dev libicu-dev libgmp-dev libzip-dev unzip; \
    rm -rf /var/lib/apt/lists/*

RUN set -xe; \
    pecl install -o -f redis; \
    rm -rf /tmp/pear; \
    docker-php-ext-enable redis

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install soap
RUN docker-php-ext-install gmp
RUN docker-php-ext-install zip
RUN docker-php-ext-install intl

RUN set -xe; \
    curl --insecure https://getcomposer.org/composer.phar -o /usr/bin/composer; \
    chmod +x /usr/bin/composer
