#!/bin/bash
git pull --rebase && \
cp .env.example .env && \
cp docker-compose.example.yml docker-compose.yml