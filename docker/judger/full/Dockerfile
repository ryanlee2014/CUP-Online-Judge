#
# Ubuntu Node.js Dockerfile
#
# https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
# https://docs.docker.com/examples/nodejs_web_app/
#

# Pull base image.
FROM ryanlee2014/cupoj-judger-env:1.2.3-full

LABEL maintainer="Ryan Lee" \
      email="gxlhybh@gmail.com"

ARG JUDGER_REPO="https://github.com/CUP-ACM-Programming-Club/CUP-Online-Judge-Judger.git"
ARG JUDGER_REF="master"
ARG DAEMON_REPO="https://github.com/ryanlee2014/CUP-Online-Judge-Judge-Daemon-Service.git"
ARG DAEMON_REF="master"
ARG NODE_MAJOR="24 22 20"
ARG NODE_MAJOR_LIST="${NODE_MAJOR}"

# Install Node.js
RUN set -xeuo pipefail && \
    git clone --depth 1 --single-branch --branch "${JUDGER_REF}" "${JUDGER_REPO}" judger && \
    cd judger && \
    ./build_docker.sh && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    cd ../ && \
    git clone --depth 1 --single-branch --branch "${DAEMON_REF}" "${DAEMON_REPO}" daemon && \
    cd daemon && \
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
      NODE_VERSION="${NODE_TARBALL#node-}" && \
      NODE_VERSION="${NODE_VERSION%%-*}" && \
      echo "Resolved Node.js tarball ${NODE_TARBALL}" && \
      curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARBALL}" -o "/tmp/${NODE_TARBALL}" && \
      printf "%s  /tmp/%s\n" "${NODE_TARBALL_SHA256}" "${NODE_TARBALL}" | sha256sum -c - && \
      tar -xJf "/tmp/${NODE_TARBALL}" -C /usr/local --strip-components=1 && \
      rm -f "/tmp/${NODE_TARBALL}" && \
      npm config set --location=global legacy-peer-deps true && \
      rm -rf node_modules && \
      npm install --legacy-peer-deps --unsafe-perm && \
      cp ../judger/wsjudged ./ && \
      chmod +x wsjudged && \
      if npm run build:main -- --skipLibCheck; then \
        NODE_BUILD_OK="true"; \
        break; \
      fi && \
      echo "Node.js ${NODE_VERSION} failed to build daemon service. Try next major."; \
    done && \
    if [ "${NODE_BUILD_OK}" != "true" ]; then \
      echo "Failed to build Judge-Daemon-Service with all Node.js majors in NODE_MAJOR_LIST=${NODE_MAJOR_LIST}"; \
      exit 1; \
    fi


# Binds to port 8080
EXPOSE  5110

#  Defines your runtime(define default command)
# These commands unlike RUN (they are carried out in the construction of the container) are run when the container
CMD cd /daemon && node ./build/index.js
