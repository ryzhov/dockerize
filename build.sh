#!/bin/sh

. ./.env

DOCKER_FILE=.docker/dev/Dockerfile
IMAGE=${REGISTRY}/php-${ENV}:${VERSION}

docker image build -t ${IMAGE} -f ${DOCKER_FILE}  .

[ $? != 0 ] && echo "build image fail, exit." &&  exit 1

echo ${IMAGE}

