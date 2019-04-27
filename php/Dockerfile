# ./docker/php/Dockerfile
FROM anryzhov/php:7.2-fpm

ARG user
ARG user_id
ARG application

RUN apt-get update && apt-get install -y procps inetutils-ping net-tools git vim vim-tiny sudo
RUN useradd -g users -G root,www-data,sudo -u ${user_id} ${user}
RUN echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /var/www/${application}/public

ENV PATH=$PATH:/var/www/${application}/vendor/bin:/var/www/${application}/bin:.
