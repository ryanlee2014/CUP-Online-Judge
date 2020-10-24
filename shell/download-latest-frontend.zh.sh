#!/bin/bash

BASEDIR=`pwd`

LATEST_VERSION=$(curl "https://api.github.com/repos/ryanlee2014/CUP-Online-Judge-CDN/tags" | grep '"name":' | sed -E 's/.*"([^"]+)".*/\1/' | head -n 1)

mkdir /tmp/cupoj-frontend

cd /tmp/cupoj-frontend

wget "https://shrill-pond-3e81.hunsh.workers.dev/https:/github.com/ryanlee2014/CUP-Online-Judge-CDN/archive/$LATEST_VERSION.zip"

unzip "$LATEST_VERSION"

mv ./CUP-Online-Judge-CDN-${LATEST_VERSION:1}/* ./

UNZIP_DIR_NAME=$(ls | grep ryan)

cd ./$UNZIP_DIR_NAME

rm -rf "$BASEDIR/wwwroot/html/*"

mkdir -p "$BASEDIR/wwwroot/html"

cp -r * "$BASEDIR/wwwroot/html"

cd "$BASEDIR"

rm -rf /tmp/cupoj-frontend
