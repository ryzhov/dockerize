# -- base image --
FROM debian:12-slim

ARG CONTDIR=/var/opt/cprocsp
ARG VERSION
ARG CPROTAR

# -- install deps --
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt update && apt-get --no-install-recommends install -y \
    procps inetutils-ping net-tools iproute2 locales

# -- set locale --
RUN sed -i -e \
  's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
   && locale-gen

ENV LANG=ru_RU.UTF-8
ENV LANGUAGE=ru_RU:ru
ENV LC_LANG=ru_RU.UTF-8
ENV LC_ALL=ru_RU.UTF-8

# -- set timezone --
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# -- sep PATH for cprocsp binaries --
ENV PATH="$PATH:/opt/cprocsp/bin/amd64:/opt/cprocsp/sbin/amd64"
ENV CPROCSP_VERSION="${VERSION}"

# -- declare volume for key containers --
VOLUME ${CONTDIR}

# -- install cryptopro packages --
RUN --mount=type=bind,source=${CPROTAR},target=/tmp/${CPROTAR} \
    cd /tmp/${CPROTAR} && ./install.sh

# -- set cryptopro license --
RUN --mount=type=secret,id=CPROCSP_LICENSE,env=CPROCSP_LICENSE \
    test -z "${CPROCSP_LICENSE}" && echo demo license mode || cpconfig -license -set ${CPROCSP_LICENSE}

# -- list containers folder --
RUN test -d "${CONTDIR}" && ls -la ${CONTDIR}

CMD [ "cpconfig", "-license", "-view" ]
