# Pull base image.
FROM ubuntu:18.04

# Install Node.js
RUN set -xe && \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    apt-get update && \
    apt-get install -y wget software-properties-common sudo && \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
    apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apt-get install --yes curl && \
    curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install -y nodejs cmake flex clang fp-compiler gcc g++ zsh libgmp-dev libmysqlclient-dev build-essential git net-tools vim && \
    apt-get install -y fp-compiler mono-devel adoptopenjdk-14-hotspot && \
    cd ~ && \
    wget https://github.com/JetBrains/kotlin/releases/download/v1.3.72/kotlin-native-linux-1.3.72.tar.gz && \
    tar -zxvf kotlin-native-linux-1.3.72.tar.gz && \
    mv kotlin-native-linux-1.3.72 /usr/lib/kotlin && \
    rm -rf kotlin-native-linux-1.3.72.tar.gz && \
    cd ~ && \
    chsh -s $(which zsh) && \
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k && \
    sed -i s/ZSH_THEME="robbyrussell"/"powerlevel9k/powerlevel9k"/g ~/.zshrc && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git && \
    echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

ENV PATH="/usr/lib/kotlin/bin:${PATH}"

CMD echo 'hello world!'