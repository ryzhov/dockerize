#!/bin/sh

. ./.env

ENV=${1:-${ENV}}

USER_NAME=`id -u -n`
USER_ID=`id -u`
DOCKER_FILE=`[ $ENV = "base" ] && echo "./Dockerfile" || echo ./${ENV}/Dockerfile`
IMAGE=${REGISTRY}/php-${ENV}:${VERSION}
BASE_IMAGE=${REGISTRY}/php-base:${VERSION}
PHP_INI=`[ $ENV = "dev" ] && echo "php.ini-development" || echo "php.ini-production"`

echo "image => \"${IMAGE}\"; env => \"${ENV}\" dockerfile => \"${DOCKER_FILE}\" php.ini => \"${PHP_INI}\""

if [ ${ENV} = "base" ]; then
    docker image build -t ${IMAGE} -f ${DOCKER_FILE} .
else
    docker image build -t ${IMAGE} -f ${DOCKER_FILE} \
        --build-arg BASE_IMAGE=${BASE_IMAGE} \
        --build-arg PHP_INI=${PHP_INI} \
        --build-arg ENV=${ENV} \
        --build-arg USER_NAME=${USER_NAME} \
        --build-arg USER_ID=${USER_ID} \
        ./${ENV}/
fi

[ $? != 0 ] && echo "build image fail, exit." &&  exit 1

echo ${IMAGE}
