# ./docker/php/Dockerfile
FROM php:fpm

ARG APCU_VERSION=5.1.18

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
COPY config/symfony.ini $PHP_INI_DIR/conf.d/
COPY config/ss-docker.conf $PHP_INI_DIR/../php-fpm.d/

RUN set -xe; \
    apt-get update; \
    apt-get install -y --no-install-recommends libmemcached-dev libxml2-dev libicu-dev libgmp-dev libzip-dev unzip libwebp-dev libjpeg-dev libpng-dev libz-mingw-w64-dev libxpm-dev libldap2-dev ; \
    rm -rf /var/lib/apt/lists/*

# Install memcached
RUN set -ex \
    && MEMCACHED="`mktemp -d`" \
    && curl -skL https://github.com/php-memcached-dev/php-memcached/archive/master.tar.gz | tar zxf - --strip-components 1 -C $MEMCACHED \
    && docker-php-ext-configure $MEMCACHED \
    && docker-php-ext-install $MEMCACHED \
    && rm -rf $MEMCACHED

# Install redis
RUN set -xe; \
    pecl install -o -f redis; \
    rm -rf /tmp/pear; \
    docker-php-ext-enable redis

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install soap
RUN docker-php-ext-install gmp
RUN docker-php-ext-install zip
RUN docker-php-ext-install intl
RUN docker-php-ext-install gd
RUN docker-php-ext-install ldap

#INSTALL APCU
RUN pecl install apcu-${APCU_VERSION} && docker-php-ext-enable apcu
RUN echo "extension=apcu.so" > /usr/local/etc/php/php.ini
RUN echo "apc.enable_cli=1" > /usr/local/etc/php/php.ini
RUN echo "apc.enable=1" > /usr/local/etc/php/php.ini
#APCU

RUN set -xe; \
    curl --insecure https://getcomposer.org/composer.phar -o /usr/bin/composer; \
    chmod +x /usr/bin/composer
