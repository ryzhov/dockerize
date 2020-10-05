ARG BASE_IMAGE
FROM ${BASE_IMAGE}

#INSTALL DEV DEPENDENCIES
RUN apt-get update && apt-get install -y inetutils-ping net-tools iproute2 git vim vim-tiny sudo
#DEPENDENCIES

#INSTALL CONFIGURATION
ARG PHP_INI
RUN mv "${PHP_INI_DIR}/${PHP_INI}" "${PHP_INI_DIR}/php.ini"
COPY symfony.ini $PHP_INI_DIR/conf.d/
COPY ss-docker.conf $PHP_INI_DIR/../php-fpm.d/
#CONFIGURATION

#ADD LOCAL USER
ARG USER_ID
ARG USER_NAME
RUN set -eux; \
    useradd -g users -G root,www-data,sudo -u ${USER_ID} ${USER_NAME}; \
    echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
#USER

ARG ENV
ENV APP_ENV=${ENV}
