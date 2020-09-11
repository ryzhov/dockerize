#!/bin/sh

. ./.env

IMAGE=${REGISTRY}/php-${ENV}:${VERSION}

echo "run php-fpm; image => ${IMAGE}; env => ${ENV};"

docker run --rm ${IMAGE}

