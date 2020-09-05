#!/bin/sh

. ./.env

DOCKER_FILE=.docker/Dockerfile
IMAGE=${REGISTRY}/php-${ENV}:${VERSION}
PHP_INI=`[ $ENV = "dev" ] && echo "php.ini-development" || echo "php.ini-production"`

echo "build php-fpm; env => ${ENV} php.ini => ${PHP_INI}"

docker image build -t ${IMAGE} -f ${DOCKER_FILE} --build-arg PHP_INI=${PHP_INI} --build-arg ENV=${ENV} .

[ $? != 0 ] && echo "build image fail, exit." &&  exit 1

echo ${IMAGE}
