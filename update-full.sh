#!/bin/bash
BASEDIR=$(dirname "$0")
source "$BASEDIR"/shell/color-shell.sh

echo -e "${BGreen}Update git repositories${Color_Off}" && \
git pull --rebase && \
bash shell/download-latest-frontend.sh && \
echo -e "${BGreen}Update .env docker-compose.yml${Color_Off}" && \
bash shell/full-env.sh && \
bash shell/recreate-container.sh && \
echo -e "Please access to server from:"
echo -e "${BGreen}"
for i in $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
do
    echo -e "http://$i:8080"
done
echo -e "${Color_Off}";
