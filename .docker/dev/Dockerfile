# ./docker/php/Dockerfile
FROM php:7.4-fpm

ARG APCU_VERSION=5.1.18

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
COPY .docker/dev/config/symfony.ini $PHP_INI_DIR/conf.d/
COPY .docker/dev/config/ss-docker.conf $PHP_INI_DIR/../php-fpm.d/

RUN set -xe; \
    apt-get update; \
    apt-get install -y --no-install-recommends libmemcached-dev libxml2-dev libicu-dev libgmp-dev libzip-dev \
        unzip libwebp-dev libjpeg-dev libpng-dev libz-mingw-w64-dev libxpm-dev libldap2-dev ; \
    rm -rf /var/lib/apt/lists/*

# Install memcached
RUN set -xe \
    && MEMCACHED="`mktemp -d`" \
    && curl -skL https://github.com/php-memcached-dev/php-memcached/archive/master.tar.gz | tar zxf - --strip-components 1 -C $MEMCACHED \
    && docker-php-ext-configure $MEMCACHED \
    && docker-php-ext-install $MEMCACHED \
    && rm -rf $MEMCACHED

#INSTALL REDIS
RUN set -xe; \
    pecl install -o -f redis; \
    docker-php-ext-enable redis; \
    rm -rf /tmp/pear
#REDIS

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install soap
RUN docker-php-ext-install gmp
RUN docker-php-ext-install zip
RUN docker-php-ext-install intl
RUN docker-php-ext-install gd
RUN docker-php-ext-install ldap

#INSTALL APCU
RUN set -xe; \
    pecl install apcu-${APCU_VERSION}; \
    docker-php-ext-enable apcu; \
    rm -rf /tmp/pear
#APCU

