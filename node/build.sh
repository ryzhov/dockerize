#!/bin/sh

. ./.env

IMAGE=${REGISTRY}/node-${ENV}:${VERSION}
USER_NAME=`id -u -n`
USER_ID=`id -u`

echo "env => ${ENV}; image => ${IMAGE}; user name => ${USER_NAME}; user id => ${USER_ID}"

docker image build -t ${IMAGE} \
    --build-arg USER_NAME=${USER_NAME} \
    --build-arg USER_ID=${USER_ID} \
    --build-arg VERSION=${VERSION} \
    .

[ $? != 0 ] && echo "build image fail, exit." &&  exit 1

echo ${IMAGE}
