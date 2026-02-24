# Pull base image.
FROM ryanlee2014/cupoj-judger-env:1.2.3

ARG KOTLIN_COMPILER_VERSION=1.3.72
ARG KOTLIN_COMPILER_SHA256=""
ARG KOTLIN_COMPILER_NAME="kotlin-compiler-${KOTLIN_COMPILER_VERSION}.zip"
ARG JUDGE_UID=1536

LABEL maintainer="Ryan Lee" \
      email="gxlhybh@gmail.com"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Kotlin compiler and judge runner user
RUN set -xeuo pipefail && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        unzip \
        xz-utils \
        libncurses5 && \
    # keep Kotlin compiler + native versions explicit when provided
    if ! id -u judge >/dev/null 2>&1; then \
      if useradd -m -u "${JUDGE_UID}" judge 2>/dev/null; then :; else useradd -m judge; fi; \
    fi && \
    judge_home="$(getent passwd judge | cut -d: -f6 || true)" && \
    if [ -z "${judge_home}" ]; then \
      judge_home="$(eval echo ~judge)" || true; \
    fi && \
    if [ -z "${judge_home}" ] || [ "${judge_home}" = "/" ]; then \
      judge_home="/home/judge"; \
    fi && \
    mkdir -p "${judge_home}" && \
    mkdir -p /tmp && \
    if ! wget -q "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_COMPILER_VERSION}/${KOTLIN_COMPILER_NAME}" -O "/tmp/${KOTLIN_COMPILER_NAME}"; then \
      echo "Failed to download Kotlin compiler package ${KOTLIN_COMPILER_NAME} for version ${KOTLIN_COMPILER_VERSION}" && \
      echo "URL: https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_COMPILER_VERSION}/${KOTLIN_COMPILER_NAME}" && \
      exit 1; \
    fi && \
    if [ -n "${KOTLIN_COMPILER_SHA256}" ]; then \
      printf "%s  /tmp/%s\n" "${KOTLIN_COMPILER_SHA256}" "${KOTLIN_COMPILER_NAME}" | sha256sum -c -; \
    else \
      echo "KOTLIN_COMPILER_SHA256 not provided, skipping compiler checksum verification"; \
    fi && \
    unzip -q "/tmp/${KOTLIN_COMPILER_NAME}" -d ~ && \
    mv /root/kotlinc /usr/lib/kotlinc && \
    rm -rf "/tmp/${KOTLIN_COMPILER_NAME}" && \
    cd ~ && \
    echo 'fun main(args: Array<String>) {println("Hello, World!")}' > hello.kt && \
    if [ ! -x /usr/lib/kotlin-native/bin/kotlinc ]; then \
      echo "Failed to locate kotlin-native compiler"; \
      exit 1; \
    fi && \
    /usr/lib/kotlin-native/bin/kotlinc hello.kt -o hello -opt && \
    mkdir -p "${judge_home}/.cache" && \
    chown -R judge:judge "${judge_home}/.cache" && \
    if [ -d ~/.konan ]; then \
      echo "Migrating ~/.konan cache to ${judge_home}/.konan"; \
      rm -rf "${judge_home}/.konan"; \
      mv ~/.konan "${judge_home}/.konan"; \
    fi && \
    if [ -d "${judge_home}/.konan" ]; then \
      chgrp -R judge "${judge_home}/.konan" && \
      chown -R judge "${judge_home}/.konan"; \
    fi && \
    rm -rf "${judge_home}/.bashrc" && \
    cd ~ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["echo", "hello world!"]
