#!/bin/bash
BASEDIR=$(dirname "$0")
source "$BASEDIR"/shell/color-shell.sh

REGION="$1"

LOCAL_FRONTEND="$2"

echo -e "${BGreen}Update git repositories${Color_Off}" && \
git pull --rebase && \
echo -e "${BGreen}Update .env docker-compose.yml${Color_Off}" && \
bash shell/base-env.sh && \
bash shell/recreate-container.sh && \
bash restart.sh && \
echo -e "Please access to server from:"
echo -e "${BGreen}"
for i in $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
do
    echo -e "http://$i:8080"
done
echo -e "${Color_Off}";
