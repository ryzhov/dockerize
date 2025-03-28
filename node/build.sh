#!/bin/sh

. ./.env
. ./.env.local

DOCKERFILE="${ENV}"/Dockerfile
IMAGE=${REGISTRY}/node:${VERSION}
USER_NAME=$(id -u -n)
USER_ID=$(id -u)

[ -f "${DOCKERFILE}" ] || { echo "dockerfile not found => ${DOCKERFILE}"; exit 1; }

echo "image => ${IMAGE}; version => ${VERSION}; user name => ${USER_NAME}; user id => ${USER_ID}"
set -xe

docker image build -t "${IMAGE}" -f "${DOCKERFILE}" --progress plain \
    --build-arg USER_NAME="${USER_NAME}" \
    --build-arg USER_ID="${USER_ID}" \
    --build-arg VERSION="${VERSION}" \
    .
