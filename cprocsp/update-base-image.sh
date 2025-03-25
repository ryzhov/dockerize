#!/bin/sh

. ./.env
. ./.env.local

BASE_IMAGE=node:${VERSION}

echo "Pull base image => \"${BASE_IMAGE}\""
docker pull ${BASE_IMAGE}
