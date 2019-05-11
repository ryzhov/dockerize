# ./docker/php/Dockerfile
FROM anryzhov/php:7.3-fpm

ARG user
ARG user_id
ARG application_path

RUN apt-get update && apt-get install -y procps inetutils-ping net-tools git vim vim-tiny sudo
RUN useradd -g users -G root,www-data,sudo -u ${user_id} ${user}
RUN echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR ${application_path}/public

ENV PATH=$PATH:${application_path}/vendor/bin:${application_path}/bin:.
