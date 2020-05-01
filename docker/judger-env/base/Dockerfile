# Pull base image.
FROM ubuntu:20.04

LABEL maintainer="Ryan Lee" \
      email="gxlhybh@gmail.com"
# Install Node.js
RUN set -xe && \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    apt-get update && \
    apt-get install -y wget software-properties-common sudo && \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
    apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apt-get install --yes curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs cmake flex clang fp-compiler  gcc g++ unzip zsh libgmp-dev libmysqlclient-dev build-essential git net-tools vim && \
    apt-get install -y fp-compiler mono-devel adoptopenjdk-14-hotspot && \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get update && \
    apt-get install -y gcc-10 g++-10 && \
    cd ~ && \
    wget https://github.com/JetBrains/kotlin/releases/download/v1.3.72/kotlin-native-linux-1.3.72.tar.gz && \
    tar -zxvf kotlin-native-linux-1.3.72.tar.gz && \
    mv kotlin-native-linux-1.3.72 /usr/lib/kotlin-native && \
    rm -rf kotlin-native-linux-1.3.72.tar.gz && \
    cd ~

ENV PATH="/usr/lib/kotlinc/bin:/usr/lib/kotlin-native/bin:${PATH}"

CMD echo 'hello world!'