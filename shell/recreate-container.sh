#!/bin/bash
BASEDIR=$(dirname "$0")
source "$BASEDIR"/color-shell.sh
echo -e "${BGreen}Recreate docker container${Color_Off}" && \
docker-compose up -d --no-deps --build --force-recreate --remove-orphans && \
docker-compose stop && \
echo -e "${BGreen}Start container""${Color_Off}" && \
docker-compose start mysql redis && \
docker-compose start cupoj-backend cupoj-judger && \
docker-compose start cupoj-websocket && \
docker-compose start nginx && \
echo -e "${BGreen}Containers have been started.${Color_Off}";
