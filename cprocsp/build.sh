#!/bin/sh

. ./.env

tar xvzf "${CPROTAR}.tgz"

VERSION=$(dpkg-deb -f "${CPROTAR}"/lsb-cprocsp-base_*_all.deb Version)
DOCKERFILE="${ENV}"/Dockerfile
IMAGE=${REGISTRY}/cprocsp:${VERSION}
export CPROCSP_LICENSE="${CPROCSP_LICENSE:-}"

[ -f "${DOCKERFILE}" ] || { echo "dockerfile not found => ${DOCKERFILE}"; exit 1; }

echo "env => ${ENV}; image => ${IMAGE}; license => ${CPROCSP_LICENSE};"
set -xe

docker build --no-cache -t "${IMAGE}" -f "${DOCKERFILE}" --progress plain \
    --secret id=CPROCSP_LICENSE \
    --build-arg VERSION="${VERSION}" \
    --build-arg CPROTAR="${CPROTAR}" \
    .

# -- remove cprocsp directory --
rm -rf "${CPROTAR}"
