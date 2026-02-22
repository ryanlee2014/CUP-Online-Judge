# Pull base image.
FROM ubuntu:20.04

ARG NODE_MAJOR=24

LABEL maintainer="Ryan Lee" \
      email="gxlhybh@gmail.com"
# Install Node.js
RUN set -xe && \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    apt-get update && \
    apt-get install -y wget software-properties-common sudo ca-certificates gnupg curl && \
    apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    install -d /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x focal main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs cmake flex clang fp-compiler gcc g++ unzip zsh libgmp-dev libmysqlclient-dev build-essential git net-tools vim && \
    apt-get install -y fp-compiler mono-devel openjdk-11-jdk && \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get update && \
    apt-get install -y gcc-10 g++-10 && \
    cd ~ && \
    wget https://github.com/JetBrains/kotlin/releases/download/v1.3.72/kotlin-native-linux-1.3.72.tar.gz && \
    tar -zxvf kotlin-native-linux-1.3.72.tar.gz && \
    mv kotlin-native-linux-1.3.72 /usr/lib/kotlin-native && \
    rm -rf kotlin-native-linux-1.3.72.tar.gz && \
    dirname $(find / -name libjli.so) > /etc/ld.so.conf.d/libjvm.conf && \
    ldconfig && \
    cd ~

ENV PATH="/usr/lib/kotlinc/bin:/usr/lib/kotlin-native/bin:${PATH}"

CMD echo 'hello world!'
