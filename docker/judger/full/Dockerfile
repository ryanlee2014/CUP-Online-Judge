#
# Ubuntu Node.js Dockerfile
#
# https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
# https://docs.docker.com/examples/nodejs_web_app/
#

# Pull base image.
FROM ryanlee2014/cupoj-judger-env:1.2.1-full

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
    npm install && \
    cp ../judger/wsjudged ./ && \
    chmod +x wsjudged && \
    npm run build:main


# Binds to port 8080
EXPOSE  5110

#  Defines your runtime(define default command)
# These commands unlike RUN (they are carried out in the construction of the container) are run when the container
CMD cd /daemon && node ./build/index.js