#!/bin/bash
BASEDIR=$(dirname "$0")
source "$BASEDIR"/shell/color-shell.sh

IMPORT_SLEEP_TIME=30

bash shell/base-env.sh && \
cp etc/backend/config.sample.json etc/backend/config.json && \
cp judge/etc/config.sample.json judge/etc/config.json && \
bash shell/download-latest-frontend.sh && \
docker-compose up -d mysql && \
echo -e "${BGreen}Container started. Sleep ${IMPORT_SLEEP_TIME} seconds.${Color_Off}" && \
sleep $IMPORT_SLEEP_TIME && \
echo -e "${BRed}Import SQL structure... this operation will erase your data." && \
docker-compose exec -T mysql mysql "-uroot" "-proot" < "./sql/structure.sql" && \
echo -e "${BWhite}Imported. Sleep 3 seconds.${Color_Off}" && \
sleep 3 && \
echo -e "${BGreen}Recreate container and start all services." && \
bash shell/recreate-container.sh && \
echo -e "${BWhite}Init system complete."
echo -e "Please access to server from:"
echo -e "${BGreen}"
for i in $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
do
    echo -e "http://$i:8080"
done
echo -e "${Color_Off}";
