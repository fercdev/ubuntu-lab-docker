FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    wget \
    git \
    nano \
    vim \
    tree \
    zip \
    unzip \
    sudo \
    htop \
    net-tools \
    iputils-ping \
    iproute2 \
    dnsutils \
    jq \
    openssh-client \
    openssh-server \
    python3 \
    python3-pip \
    nodejs \
    npm \
    gcc \
    g++ \
    make \
    procps \
    ca-certificates \
    software-properties-common \
    apt-transport-https \
    lsb-release \
    docker.io \
    && apt-get clean

RUN useradd -ms /bin/bash estudiante && \
    echo "estudiante:123456" | chpasswd && \
    adduser estudiante sudo

USER estudiante

WORKDIR /home/estudiante

CMD ["/bin/bash"]