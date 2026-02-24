# Pull base image.
FROM ryanlee2014/cupoj-judger-env:1.2.3

ARG KOTLIN_COMPILER_VERSION=1.3.72
ARG KOTLIN_COMPILER_SHA256=""
ARG KOTLIN_COMPILER_NAME="kotlin-compiler-${KOTLIN_COMPILER_VERSION}.zip"
ARG JUDGE_UID=1536

LABEL maintainer="Ryan Lee" \
      email="gxlhybh@gmail.com"

# Install Node.js
RUN set -xeuo pipefail && \
    apt-get update && \
    apt-get install -y --no-install-recommends libncurses5 && \
    if ! id -u judge >/dev/null 2>&1; then \
      if useradd -m -u "${JUDGE_UID}" judge 2>/dev/null; then :; else useradd -m judge; fi; \
    fi && \
    cd ~ && \
    wget -q "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_COMPILER_VERSION}/${KOTLIN_COMPILER_NAME}" -O "/tmp/${KOTLIN_COMPILER_NAME}" && \
    if [ -n "${KOTLIN_COMPILER_SHA256}" ]; then \
      printf "%s  /tmp/%s\n" "${KOTLIN_COMPILER_SHA256}" "${KOTLIN_COMPILER_NAME}" | sha256sum -c -; \
    fi && \
    unzip -q "/tmp/${KOTLIN_COMPILER_NAME}" -d ~ && \
    mv /root/kotlinc /usr/lib/kotlinc && \
    rm -rf "/tmp/${KOTLIN_COMPILER_NAME}" && \
    cd ~ && \
    echo 'fun main(args: Array<String>) {println("Hello, World!")}' > hello.kt && \
    /usr/lib/kotlin-native/bin/kotlinc hello.kt -o hello -opt && \
    mkdir -p /home/judge && \
    if [ -d ~/.konan ]; then \
      mv ~/.konan /home/judge/.konan; \
    fi && \
    if [ -d /home/judge/.konan ]; then \
      chgrp -R judge /home/judge/.konan && \
      chown -R judge /home/judge/.konan; \
    fi && \
    rm -rf /home/judge/.bashrc && \
    cd ~ && \
    rm -rf /var/lib/apt/lists/*

CMD echo 'hello world!'
