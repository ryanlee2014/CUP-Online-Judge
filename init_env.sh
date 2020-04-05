!#/bin/bash
cp .env.example .env && \
cp docker-compose.example.yml docker-compose.yml && \
cp etc/backend/config.sample.json etc/backend/config.json && \
cp judge/etc/config.sample.json judge/etc/config.json && \
docker-compose up -d && \
docker-compose exec -T mysql mysql "-uroot" "-proot" < ./sql/structure.sql && \
docker-compose restart