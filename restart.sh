#!/bin/bash
BASEDIR=$(dirname "$0")

source "$BASEDIR"/shell/color-shell.sh

echo -e "${BGreen}Restart all containers.${Color_Off}" && \
bash "$BASEDIR"/stop.sh && \
bash "$BASEDIR"/start.sh && \
echo -e "${BGreen}All containers have been restarted.${Color_Off}" || \
echo -e "${BRed}Failed to restart all containers.${Color_Off}"