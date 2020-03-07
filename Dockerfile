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
    apt-get install --yes curl && \
    curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install -y nodejs cmake clang fp-compiler gcc g++ libgmp-dev libmysqlclient-dev build-essential git net-tools vim && \
    git clone https://github.com/CUP-ACM-Programming-Club/CUP-Online-Judge-Judger.git judger && \
    cd judger && \
    cmake ./ && make && chmod a+x judge_client && mv ./judge_client /usr/bin && \
    mkdir /home/judge && \
    mkdir /home/judge/etc && \
    mkdir /dev/shm/cupoj && \
    mkdir /dev/shm/cupoj/submission && \
    mkdir -p /home/judge/submission && \
    useradd -m -u 1536 judge && \
    chown -R judge /home/judge && \
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