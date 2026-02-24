# Pull base image.
FROM ubuntu:20.04

ARG NODE_MAJOR=24
ARG NODEJS_SHA256=""
ARG KOTLIN_NATIVE_VERSION=1.3.72
ARG KOTLIN_NATIVE_SHA256=""
ARG KOTLIN_NATIVE_NAME="kotlin-native-linux-${KOTLIN_NATIVE_VERSION}"

LABEL maintainer="Ryan Lee" \
      email="gxlhybh@gmail.com"

# Install Node.js
RUN set -xeuo pipefail && \
    apt-get update && \
    apt-get install -y --no-install-recommends wget software-properties-common sudo ca-certificates gnupg curl xz-utils && \
    export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    NODE_TARBALL_INFO="$(curl -fsSL "https://nodejs.org/dist/latest-v${NODE_MAJOR}.x/SHASUMS256.txt" | awk -v major="${NODE_MAJOR}" '$2 ~ "^node-" major "\\.[0-9]+\\.[0-9]+-linux-x64\\.tar\\.xz$" {print $1 " " $2; exit}')" && \
    NODE_TARBALL="${NODE_TARBALL_INFO#* }" && \
    NODE_TARBALL_SHA256="${NODE_TARBALL_INFO%% *}" && \
    if [ -z "${NODE_TARBALL_SHA256}" ] || [ -z "${NODE_TARBALL}" ]; then \
      echo "Failed to resolve latest Node ${NODE_MAJOR} LTS tarball" && \
      exit 1; \
    fi && \
    if [ -n "${NODEJS_SHA256}" ] && [ "${NODEJS_SHA256}" != "${NODE_TARBALL_SHA256}" ]; then \
      echo "Node.js SHA256 mismatch, expected ${NODEJS_SHA256} but got ${NODE_TARBALL_SHA256}" && \
      exit 1; \
    fi && \
    NODE_VERSION="$(printf '%s' "${NODE_TARBALL}" | cut -d'-' -f2)" && \
    curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARBALL}" -o "/tmp/${NODE_TARBALL}" && \
    printf "%s  /tmp/%s\n" "${NODE_TARBALL_SHA256}" "/tmp/${NODE_TARBALL}" | sha256sum -c - && \
    tar -xJf "/tmp/${NODE_TARBALL}" -C /usr/local --strip-components=1 && \
    rm -f "/tmp/${NODE_TARBALL}" && \
    apt-get update && \
    apt-get install -y --no-install-recommends cmake flex clang fp-compiler gcc g++ unzip zsh libgmp-dev libmysqlclient-dev build-essential git net-tools vim fp-compiler mono-devel openjdk-11-jdk && \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends gcc-10 g++-10 && \
    cd ~ && \
    KOTLIN_NATIVE_TARBALL="${KOTLIN_NATIVE_NAME}.tar.gz" && \
    wget -q "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_NATIVE_VERSION}/${KOTLIN_NATIVE_TARBALL}" -O "/tmp/${KOTLIN_NATIVE_TARBALL}" && \
    if [ -n "${KOTLIN_NATIVE_SHA256}" ]; then \
      printf "%s  /tmp/%s\n" "${KOTLIN_NATIVE_SHA256}" "${KOTLIN_NATIVE_TARBALL}" | sha256sum -c -; \
    fi && \
    tar -zxvf "/tmp/${KOTLIN_NATIVE_TARBALL}" -C / && \
    mv /"${KOTLIN_NATIVE_NAME}" /usr/lib/kotlin-native && \
    rm -f "/tmp/${KOTLIN_NATIVE_TARBALL}" && \
    JAVA_BIN="$(command -v java || true)" && \
    if [ -z "${JAVA_BIN}" ]; then \
      echo "Failed to locate java executable" && \
      exit 1; \
    fi && \
    JAVA_HOME_GUESS="$(dirname "$(dirname "${JAVA_BIN}")")" && \
    LIBJLI_PATH="$(find "${JAVA_HOME_GUESS}" -name libjli.so 2>/dev/null | head -n 1 || true)" && \
    if [ -z "${LIBJLI_PATH}" ]; then \
      LIBJLI_PATH="$(find /usr/lib/jvm -name libjli.so 2>/dev/null | head -n 1 || true)"; \
    fi && \
    if [ -z "${LIBJLI_PATH}" ]; then \
      echo "Failed to locate libjli.so" && \
      exit 1; \
    fi && \
    dirname "${LIBJLI_PATH}" > /etc/ld.so.conf.d/libjvm.conf && \
    ldconfig && \
    cd ~ && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/lib/kotlinc/bin:/usr/lib/kotlin-native/bin:${PATH}"

CMD echo 'hello world!'
