ARG VERSION

# -- main image --
FROM node:${VERSION}

ARG WORKDIR=/usr/local/bin
ARG USER_NAME
ARG USER_ID

# -- install tools --
RUN apt-get update && apt-get install -y \
    curl wget procps inetutils-ping net-tools iproute2 git vim vim-tiny \
    sudo gettext build-essential jq locales unzip bash-completion mariadb-client

# -- install bun --
RUN curl -fsSL https://bun.sh/install | bash && mv ~/.bun/bin/bun /usr/local/bin && bun --version

# -- create local user --
RUN useradd -g users -G root,www-data,sudo -u ${USER_ID} ${USER_NAME} -s /bin/bash \
    && echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

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

WORKDIR ${WORKDIR}
COPY sleep.js .
CMD [ "node", "/usr/local/bin/sleep.js" ]

