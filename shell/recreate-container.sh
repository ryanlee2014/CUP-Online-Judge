#!/bin/bash
BASEDIR=$(dirname "$0")
source "$BASEDIR"/color-shell.sh
echo -e "${BGreen}Recreate docker container${Color_Off}" && \
docker-compose up -d --no-deps --build --force-recreate --remove-orphans