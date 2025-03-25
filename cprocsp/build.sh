#!/bin/sh

. ./.env


tar xvzf "${CPROTAR}.tgz"

VERSION=$(dpkg-deb -f "${CPROTAR}"/lsb-cprocsp-base_*_all.deb Version)
DOCKERFILE="${ENV}"/Dockerfile
IMAGE=${REGISTRY}/cprocsp:${VERSION}

[ -f "${DOCKERFILE}" ] || { echo "dockerfile not found => ${DOCKERFILE}"; exit 1; }

echo "env => ${ENV}; image => ${IMAGE}; version => ${VERSION};"
set -xe

docker image build -t "${IMAGE}" -f "${DOCKERFILE}" --progress plain \
    --build-arg VERSION="${VERSION}" \
    --build-arg CPROTAR="${CPROTAR}" \
    .


# -- remove cprocsp directory --
rm -rf "${CPROTAR}"
