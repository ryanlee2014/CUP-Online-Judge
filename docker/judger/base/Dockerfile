#
# Ubuntu Node.js Dockerfile
#
# https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
# https://docs.docker.com/examples/nodejs_web_app/
#

# Pull base image.
FROM ryanlee2014/cupoj-judger-env:1.2.3

LABEL maintainer="Ryan Lee" \
      email="gxlhybh@gmail.com"

# Install Node.js
RUN set -xe && \
    git clone https://github.com/CUP-ACM-Programming-Club/CUP-Online-Judge-Judger.git judger && \
    cd judger && \
    ./build_docker.sh && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    cd ../ && \
    git clone https://github.com/ryanlee2014/CUP-Online-Judge-Judge-Daemon-Service.git daemon && \
    cd daemon && \
    NODE_TARBALL="" && \
    for MAJOR in 24 22 20; do \
        CANDIDATE="$(curl -fsSL "https://nodejs.org/dist/latest-v${MAJOR}.x/SHASUMS256.txt" | awk '{print $2}' | grep -E "^node-v${MAJOR}\\.[0-9]+\\.[0-9]+-linux-x64\\.tar\\.xz$" | head -n 1 || true)" && \
        if [ -n "${CANDIDATE}" ]; then \
            NODE_TARBALL="${CANDIDATE}" && \
            break; \
        fi; \
    done && \
    if [ -z "${NODE_TARBALL}" ]; then \
        echo "Failed to resolve a supported Node.js LTS tarball" && \
        exit 1; \
    fi && \
    NODE_VERSION="${NODE_TARBALL#node-}" && \
    NODE_VERSION="${NODE_VERSION%%-*}" && \
    curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARBALL}" -o "/tmp/${NODE_TARBALL}" && \
    tar -xJf "/tmp/${NODE_TARBALL}" -C /usr/local --strip-components=1 && \
    rm -f "/tmp/${NODE_TARBALL}" && \
    npm config set --location=global legacy-peer-deps true && \
    npm install --legacy-peer-deps --unsafe-perm && \
    cp ../judger/wsjudged ./ && \
    chmod +x wsjudged && \
    npm run build:main -- --skipLibCheck


# Binds to port 8080
EXPOSE  5110

#  Defines your runtime(define default command)
# These commands unlike RUN (they are carried out in the construction of the container) are run when the container
CMD cd /daemon && node ./build/index.js
