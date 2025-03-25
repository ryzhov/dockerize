# -- base image --
FROM debian:12-slim

ARG WORKDIR=/opt/cprocsp/bin/amd64
ARG VERSION
ARG CPROTAR

# -- install tools --
RUN apt-get update && apt-get install -y \
    curl wget procps inetutils-ping net-tools iproute2 locales

# Locale
RUN sed -i -e \
  's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
   && locale-gen

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:ru
ENV LC_LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

# +Timezone
ENV TZ Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# PATH
ENV PATH "$PATH:/opt/cprocsp/bin/amd64:/opt/cprocsp/sbin/amd64"
VOLUME /var/opt/cprocsp

RUN --mount=type=bind,source=${CPROTAR},target=/tmp/${CPROTAR} \
    cd /tmp/${CPROTAR} && \
   	./install.sh

WORKDIR ${WORKDIR}
CMD [ "/opt/cprocsp/sbin/amd64/cpconfig", "-license", "-view" ]
