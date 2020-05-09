#!/bin/bash

BASEDIR=`pwd`

LATEST_VERSION=$(curl "https://api.github.com/repos/ryanlee2014/CUP-Online-Judge-CDN/tags" | grep '"name":' | sed -E 's/.*"([^"]+)".*/\1/' | head -n 1)

mkdir /tmp/cupoj-frontend

cd /tmp/cupoj-frontend

wget "https://api.github.com/repos/ryanlee2014/CUP-Online-Judge-CDN/zipball/$LATEST_VERSION"

unzip "$LATEST_VERSION"

UNZIP_DIR_NAME=$(ls | grep ryan)

cd ./$UNZIP_DIR_NAME

rm -rf "$BASEDIR/wwwroot/html/*"

mkdir -p "$BASEDIR/wwwroot/html"

cp -r * "$BASEDIR/wwwroot/html"

cd "$BASEDIR"

rm -rf /tmp/cupoj-frontend