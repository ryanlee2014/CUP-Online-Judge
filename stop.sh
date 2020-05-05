#!/bin/bash
BASEDIR=$(dirname "$0")

source "$BASEDIR"/shell/color-shell.sh

if [[ "$#" != 0 ]]; then
    for var in "$@"
    do
        echo -e "${BGreen}Stopping $var${Color_Off}"
        docker-compose stop "$var" && \
        echo -e "${BGreen}$var has been stopped.${Color_Off}" || \
        echo -e "${BRed}Failed to stop $var${Color_Off}"
    done
else
    echo -e "${BGreen}Stop all containers.${Color_Off}"
    docker-compose stop
fi

echo -e "${BGreen}Stopped.${Color_Off}"