# Pull base image.
FROM ubuntu:20.04

ARG NODE_MAJOR=24

LABEL maintainer="Ryan Lee" \
      email="gxlhybh@gmail.com"
# Install Node.js
RUN set -xe && \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    apt-get update && \
    apt-get install -y wget software-properties-common sudo ca-certificates gnupg curl xz-utils && \
    apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    NODE_TARBALL="$(curl -fsSL "https://nodejs.org/dist/latest-v${NODE_MAJOR}.x/SHASUMS256.txt" | awk '{print $2}' | grep -E "^node-v${NODE_MAJOR}\\.[0-9]+\\.[0-9]+-linux-x64\\.tar\\.xz$" | head -n 1)" && \
    if [ -z "${NODE_TARBALL}" ]; then \
      echo "Failed to resolve latest Node ${NODE_MAJOR} LTS tarball" && \
      exit 1; \
    fi && \
    NODE_VERSION="$(printf '%s' "${NODE_TARBALL}" | cut -d'-' -f2)" && \
    curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARBALL}" -o "/tmp/${NODE_TARBALL}" && \
    tar -xJf "/tmp/${NODE_TARBALL}" -C /usr/local --strip-components=1 && \
    rm -f "/tmp/${NODE_TARBALL}" && \
    apt-get update && \
    apt-get install -y cmake flex clang fp-compiler gcc g++ unzip zsh libgmp-dev libmysqlclient-dev build-essential git net-tools vim && \
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
