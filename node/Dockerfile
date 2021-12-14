ARG VERSION

FROM node:${VERSION}

ARG USER_NAME
ARG USER_ID

# -- install tools --
RUN apt-get update && apt-get install -y \
    curl procps inetutils-ping net-tools iproute2 git vim vim-tiny \
    sudo gettext build-essential python jq locales unzip

# -- k8s apt repository && kubectl --
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update && apt-get install -y kubectl

# -- install helm --
RUN curl -fsSLo get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh

# -- install aws --
RUN curl -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
    && unzip awscliv2.zip &&  ./aws/install

RUN npm install -g npm@latest

RUN useradd -g users -G root,www-data,sudo -u ${USER_ID} ${USER_NAME} -s /bin/bash && \
    echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

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

