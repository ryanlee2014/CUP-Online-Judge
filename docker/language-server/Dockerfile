#
# Ubuntu Node.js Dockerfile
#
# https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
# https://docs.docker.com/examples/nodejs_web_app/
#

# Pull base image.
FROM ryanlee2014/cupoj-judger-env:1.2.1

COPY ./docker/language-server/servers.yml /servers.yml

LABEL maintainer="Ryan Lee" \
      email="gxlhybh@gmail.com"

# Install Node.js
RUN set -xe && \
    git clone --depth=1 --recursive https://github.com/MaskRay/ccls.git ccls && \
    cd ccls && \
    wget -c https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz && \
    tar xf clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz && \
    cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04 && \
    cmake --build Release && \
    cmake --build Release --target install & \
    cd / && \
    git clone https://github.com/wylieconlon/jsonrpc-ws-proxy.git wsproxy && \
    cd wsproxy && \
    npm i && \
    npm run build

# Binds to port 8080
EXPOSE  17779

#  Defines your runtime(define default command)
# These commands unlike RUN (they are carried out in the construction of the container) are run when the container
CMD cd wsproxy && node dist/server.js --port 17779 --languageServers /servers.yml