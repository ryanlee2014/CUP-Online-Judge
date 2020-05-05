#!/bin/bash
BASEDIR=$(dirname "$0")
source "$BASEDIR"/shell/color-shell.sh

if [[ "$#" != 0 ]]; then
    for var in "$@"
    do
        echo -e "${BGreen}Starting $var${Color_Off}"
        docker-compose start "$var" && \
        echo -e "${BGreen}$var has been started.${Color_Off}" || \
        echo -e "${BRed}Failed to start $var${Color_Off}";
    done
else
    echo -e "${BGreen}Start containers${Color_Off}" && \
    docker-compose start mysql redis && \
    docker-compose start cupoj-backend cupoj-judger && \
    docker-compose start cupoj-websocket && \
    docker-compose start nginx && \
    echo -e "${BGreen}All Containers have been started.${Color_Off}"
fi

