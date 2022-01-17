#!/bin/sh

. ./.env
. ./.env.local

IMAGE=${REGISTRY}/node-${ENV}:${VERSION}
USER_NAME=$(id -u -n)
USER_ID=$(id -u)

echo "image => ${IMAGE}; version => ${VERSION}; user name => ${USER_NAME}; user id => ${USER_ID}"
set -xe

docker image build -t "${IMAGE}" \
    --build-arg USER_NAME="${USER_NAME}" \
    --build-arg USER_ID="${USER_ID}" \
    --build-arg VERSION="${VERSION}" \
    .
