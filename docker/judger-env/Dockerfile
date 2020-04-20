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
    apt-get install -y nodejs cmake flex clang fp-compiler gcc wget g++ libgmp-dev libmysqlclient-dev build-essential git net-tools vim && \
    apt-get install -y fp-compiler openjdk-11-jdk mono-devel && \
    cd ~ && \
    wget https://github.com/JetBrains/kotlin/releases/download/v1.3.72/kotlin-native-linux-1.3.72.tar.gz && \
    tar -zxvf kotlin-native-linux-1.3.72.tar.gz && \
    cd kotlin-native-linux-1.3.72/bin && \
    echo "export PATH=$(pwd):$PATH" >> /etc/profile && \
    source /etc/profile && \
    cd ~
CMD echo 'hello world!'