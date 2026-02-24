# Pull base image.
FROM ubuntu:20.04

ARG NODE_MAJOR=24
ARG NODEJS_SHA256=""
ARG KOTLIN_NATIVE_VERSION=1.3.72
ARG KOTLIN_NATIVE_SHA256=""
ARG KOTLIN_NATIVE_NAME="kotlin-native-linux-${KOTLIN_NATIVE_VERSION}"

LABEL maintainer="Ryan Lee" \
      email="gxlhybh@gmail.com"

# Install Node.js and language toolchains
RUN set -xeuo pipefail && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        software-properties-common \
        sudo \
        wget \
        xz-utils && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    NODE_MAJOR_LIST="${NODE_MAJOR}" && \
    NODE_BUILD_OK="false" && \
    for MAJOR in ${NODE_MAJOR_LIST}; do \
      echo "Trying Node.js ${MAJOR} LTS" && \
      NODE_TARBALL_INFO="$(curl -fsSL "https://nodejs.org/dist/latest-v${MAJOR}.x/SHASUMS256.txt" | awk -v major="${MAJOR}" '$2 ~ "^node-v" major "\\.[0-9]+\\.[0-9]+-linux-x64\\.tar\\.xz$" { print $1 " " $2; exit }' || true)" && \
      if [ -z "${NODE_TARBALL_INFO}" ]; then \
        echo "No tarball found for Node.js major ${MAJOR}, skip." && \
        continue; \
      fi && \
      NODE_TARBALL="${NODE_TARBALL_INFO#* }" && \
      NODE_TARBALL_SHA256="${NODE_TARBALL_INFO%% *}" && \
      if [ -n "${NODEJS_SHA256}" ] && [ "${NODEJS_SHA256}" != "${NODE_TARBALL_SHA256}" ]; then \
        echo "Node.js SHA256 mismatch for major ${MAJOR}, expected ${NODEJS_SHA256} but got ${NODE_TARBALL_SHA256}" && \
        exit 1; \
      fi && \
      NODE_VERSION="$(printf '%s' "${NODE_TARBALL}" | cut -d'-' -f2)" && \
      if ! curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARBALL}" -o "/tmp/${NODE_TARBALL}"; then \
        echo "Failed to download Node.js ${NODE_TARBALL}, try next major" && \
        continue; \
      fi && \
      if ! printf "%s  /tmp/%s\n" "${NODE_TARBALL_SHA256}" "/tmp/${NODE_TARBALL}" | sha256sum -c -; then \
        echo "SHA256 mismatch for ${NODE_TARBALL}, try next major" && \
        continue; \
      fi && \
      tar -xJf "/tmp/${NODE_TARBALL}" -C /usr/local --strip-components=1 && \
      rm -f "/tmp/${NODE_TARBALL}" && \
      NODE_BUILD_OK="true" && \
      break; \
    done && \
    if [ "${NODE_BUILD_OK}" != "true" ]; then \
      echo "Failed to install Node.js from majors: ${NODE_MAJOR_LIST}" && \
      exit 1; \
    fi && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        clang \
        fp-compiler \
        gcc \
        g++ \
        git \
        libgmp-dev \
        libmysqlclient-dev \
        mono-devel \
        net-tools \
        unzip \
        vim \
        zsh && \
    if ! apt-get install -y --no-install-recommends openjdk-11-jdk; then \
      echo "openjdk-11-jdk not available, fallback to default-jdk"; \
      apt-get install -y --no-install-recommends default-jdk; \
    fi && \
    if add-apt-repository ppa:ubuntu-toolchain-r/test -y; then \
      apt-get update && \
      apt-get install -y --no-install-recommends gcc-10 g++-10 || true; \
    else \
      echo "Skipping optional ubuntu-toolchain-r/test PPA; using default compilers"; \
    fi && \
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
    JAVA_BIN_DIR="$(dirname "${JAVA_BIN}")" && \
    JAVA_HOME_GUESS="${JAVA_HOME:-$(dirname "${JAVA_BIN_DIR}")}" && \
    LIBJLI_PATH="$(find "${JAVA_HOME_GUESS}" -maxdepth 5 -name libjli.so 2>/dev/null | head -n 1 || true)" && \
    if [ -z "${LIBJLI_PATH}" ]; then \
      LIBJLI_PATH="$(find /usr/lib/jvm -maxdepth 6 -name libjli.so 2>/dev/null | head -n 1 || true)"; \
    fi && \
    if [ -z "${LIBJLI_PATH}" ]; then \
      echo "Failed to locate libjli.so" && \
      exit 1; \
    fi && \
    if [ ! -e "${LIBJLI_PATH}" ]; then \
      echo "Invalid libjli path: ${LIBJLI_PATH}" && \
      exit 1; \
    fi && \
    dirname "${LIBJLI_PATH}" > /etc/ld.so.conf.d/libjvm.conf && \
    ldconfig && \
    cd ~ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/lib/kotlinc/bin:/usr/lib/kotlin-native/bin:${PATH}"

CMD echo 'hello world!'
