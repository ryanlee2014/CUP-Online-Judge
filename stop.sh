#!/bin/bash
BASEDIR=$(dirname "$0")

source $BASEDIR/color-shell.sh

echo -e "${BGreen}Stop all containers.${Color_Off}" && \
docker-compose stop && \
echo -e "${BGreen}Stopped.${Color_Off}"