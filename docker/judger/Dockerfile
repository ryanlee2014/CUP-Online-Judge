#
# Ubuntu Node.js Dockerfile
#
# https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
# https://docs.docker.com/examples/nodejs_web_app/
#

# Pull base image.
FROM ubuntu:18.04

# Install Node.js
RUN set -xe && \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/http:\/\/security.ubuntu.com/http:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apt-get install --yes curl && \
    curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install -y nodejs cmake flex clang fp-compiler gcc g++ libgmp-dev libmysqlclient-dev build-essential git net-tools vim && \
    git clone https://github.com/CUP-ACM-Programming-Club/CUP-Online-Judge-Judger.git judger && \
    cd judger && \
    mkdir -p ./sim/shell && \
    touch ./sim/shell/build_config.sh && \
    chmod +x ./sim/shell/build_config.sh && \
    ./build.sh && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    cd ../ && \
    git clone https://github.com/ryanlee2014/CUP-Online-Judge-Judge-Daemon-Service.git daemon && \
    cd daemon && \
    npm i -g pm2 && \
    npm install && \
    cp ../judger/wsjudged ./ && \
    chmod +x wsjudged && \
    npm run build:main


# Binds to port 8080
EXPOSE  5110

#  Defines your runtime(define default command)
# These commands unlike RUN (they are carried out in the construction of the container) are run when the container
CMD cd /daemon && node ./build/index.js