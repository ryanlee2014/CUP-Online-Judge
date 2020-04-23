#!/bin/bash
BASEDIR=$(dirname "$0")
source $BASEDIR/color-shell.sh
echo -e "${BGreen}Recreate docker container${Color_Off}" && \
docker-compose up -d --no-deps --build --force-recreate && \
docker-compose stop && \
echo -e "${BGreen}Start container"${Color_Off} && \
docker-compose start mysql && \
docker-compose start redis && \
docker-compose start cupoj-backend && \
docker-compose start cupoj-judger && \
docker-compose start cupoj-websocket && \
docker-compose start nginx && \
echo -e "${BGreen}Containers have been started.${Color_Off}";
