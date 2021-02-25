FROM bash:5.1.4

RUN apk add --no-cache \
    git \
    make \
    openssl-dev \
    ssh \
    gcc \
    libc-dev \
    bash \
    gettext \
    curl \
    wget \
    zip \
    coreutils \
    diffutils

RUN mkdir /root/.ssh && ssh-keyscan -t rsa gitlab.com >> /root/.ssh/known_hosts

COPY config /root/.ssh/config
COPY bash-ci-entrypoint.sh /usr/bin/bash-ci-entrypoint.sh

ENTRYPOINT ["bash-ci-entrypoint.sh"]
