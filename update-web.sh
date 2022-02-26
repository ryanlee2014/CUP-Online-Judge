#!/bin/bash
BASEDIR=$(dirname "$0")
source "$BASEDIR"/shell/color-shell.sh

REGION="$1"

FRONTEND_MIRROR=""

LOCAL_FRONTEND_MIRROR=".local"

if [[ "$REGION" != "" ]]; then
  FRONTEND_MIRROR=".$REGION"
fi

FRONTEND_SHELL="shell/download-latest-frontend$FRONTEND_MIRROR$LOCAL_FRONTEND_MIRROR.sh"

chmod +x $FRONTEND_SHELL

echo -e "${BGreen}Update git repositories${Color_Off}" && \
bash $FRONTEND_SHELL
