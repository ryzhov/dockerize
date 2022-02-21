ARG VERSION

# -- getting buildx binary
FROM alpine:3.13 AS buildx-fetcher
ENV BUILDX_VERSION 0.5.1
RUN apk add --no-cache curl
RUN curl -L \
  --output /docker-buildx \
  "https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64"
RUN chmod a+x /docker-buildx

# -- main image --
FROM node:${VERSION}

ARG USER_NAME
ARG USER_ID

# -- install tools --
RUN apt-get update && apt-get install -y \
    curl wget procps inetutils-ping net-tools iproute2 git vim vim-tiny \
    sudo gettext build-essential python jq locales unzip bash-completion

# -- k8s apt repository && kubectl --
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update && apt-get install -y kubectl

# -- kubectx && kubens --
RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx \
    && ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx \
    && ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# -- install helm --
RUN curl -fsSLo get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh

# -- install aws --
RUN curl -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
    && unzip awscliv2.zip &&  ./aws/install

# -- install docker-in-docker --
ENV DOCKER_VERSION 20.10.12
RUN set -eux; \
    url='https://download.docker.com/linux/static/stable/x86_64/docker-20.10.12.tgz'; \
    wget -O docker.tgz "$url"; \
    tar --extract \
        --file docker.tgz \
        --strip-components 1 \
        --directory /usr/local/bin/ \
    ; \
    rm docker.tgz; \
    dockerd --version; \
    docker --version

ENV DOCKER_TLS_CERTDIR=/certs
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client
COPY --from=buildx-fetcher /docker-buildx /usr/lib/docker/cli-plugins/docker-buildx

# -- install npm --
RUN npm install -g npm@latest

RUN groupadd -g 998 docker \
    && useradd -g users -G root,www-data,sudo,docker -u ${USER_ID} ${USER_NAME} -s /bin/bash \
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

