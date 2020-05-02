# CUP Online Judge

![License](https://img.shields.io/github/license/ryanlee2014/CUP-Online-Judge)
![GitHub package.json version (branch)](https://img.shields.io/github/package-json/v/ryanlee2014/CUP-Online-Judge-Frontend/typescript?label=Frontend)
![GitHub package.json version (branch)](https://img.shields.io/github/package-json/v/CUP-ACM-Programming-Club/CUP-Online-Judge-Express/typescript?label=Backend)
![jsDelivr hits (GitHub)](https://img.shields.io/jsdelivr/gh/hm/ryanlee2014/CUP-Online-Judge-CDN)

|name|pulls|version|layers|image size|
|:---:|:---:|:---:|:---:|:---:|
|[ryanlee2014/cupoj-backend](https://hub.docker.com/r/ryanlee2014/cupoj-backend)|![Pulls Count](https://img.shields.io/docker/pulls/ryanlee2014/cupoj-backend)|![GitHub release (latest by date)](https://img.shields.io/github/v/tag/CUP-ACM-Programming-Club/CUP-Online-Judge-Express)|![Layers](https://shields.beevelop.com/docker/image/layers/ryanlee2014/cupoj-backend/latest.svg)|![image size](https://img.shields.io/docker/image-size/ryanlee2014/cupoj-backend)|
|[ryanlee2014/cupoj-websocket](https://hub.docker.com/r/ryanlee2014/cupoj-websocket)|![Pulls Count](https://img.shields.io/docker/pulls/ryanlee2014/cupoj-websocket)|![GitHub release (latest by date)](https://img.shields.io/github/v/tag/CUP-ACM-Programming-Club/CUP-Online-Judge-Express)|![Layers](https://shields.beevelop.com/docker/image/layers/ryanlee2014/cupoj-websocket/latest.svg)|![image size](https://img.shields.io/docker/image-size/ryanlee2014/cupoj-websocket)|
|[ryanlee2014/cupoj-judger](https://hub.docker.com/r/ryanlee2014/cupoj-judger)|![Pulls Count](https://img.shields.io/docker/pulls/ryanlee2014/cupoj-judger)|![GitHub release (latest by date)](https://img.shields.io/github/v/tag/CUP-ACM-Programming-Club/CUP-Online-Judge-Judger)|![Layers](https://shields.beevelop.com/docker/image/layers/ryanlee2014/cupoj-judger/latest.svg)|![image size](https://img.shields.io/docker/image-size/ryanlee2014/cupoj-judger)|
|[ryanlee2014/cupoj-frontend](https://github.com/ryanlee2014/CUP-Online-Judge-Frontend)|![GitHub commit activity](https://img.shields.io/github/commit-activity/w/ryanlee2014/CUP-Online-Judge-Frontend)|||![GitHub repo size](https://img.shields.io/github/repo-size/ryanlee2014/CUP-Online-Judge-CDN)|
|[metowolf/nginx](https://hub.docker.com/r/metowolf/nginx)|![Pulls Count](https://img.shields.io/docker/pulls/metowolf/nginx.svg)|![GitHub release (latest by date)](https://img.shields.io/github/v/tag/metowolf/docker-nginx)|![](https://shields.beevelop.com/docker/image/layers/metowolf/nginx/latest.svg)|![](https://shields.beevelop.com/docker/image/image-size/metowolf/nginx/latest.svg)|
|[mysql/mysql-server](https://hub.docker.com/r/mysql/mysql-server)|![Pulls Count](https://img.shields.io/docker/pulls/mysql/mysql-server.svg)||![](https://shields.beevelop.com/docker/image/layers/mysql/mysql-server/latest.svg)|![](https://shields.beevelop.com/docker/image/image-size/mysql/mysql-server/latest.svg)|
|[metowolf/redis](https://hub.docker.com/r/metowolf/redis)|![Pulls Count](https://img.shields.io/docker/pulls/metowolf/redis.svg)|![GitHub release (latest by date)](https://img.shields.io/github/v/tag/metowolf/docker-redis)|![](https://shields.beevelop.com/docker/image/layers/metowolf/redis/latest.svg)|![](https://shields.beevelop.com/docker/image/image-size/metowolf/redis/latest.svg)|

## 运行要求
安装 [Docker](https://get.docker.com/) and [Docker Compose](https://docs.docker.com/compose/install/)

[安装手册](/docs/INSTALL_DOCKER.zh-cn.md)

## 使用方法(整合脚本)
```bash
./init-env.sh
```

## 升级(整合脚本)
```bash
./update.sh
```

## 使用方法(手动部署)
1. Clone该仓库到本地
```bash
git clone --recursive https://github.com/ryanlee2014/CUP-Online-Judge-NG-Docker-Judger.git docker-judger
```

2. 进入文件夹后，将 .env.example 重命名为 .env, docker-compose.example.yml 重命名为 docker-compose.yml
```bash
cd docker-judger
cp .env.example .env
cp docker-compose.example.xml docker.compose.yml
```

3. 进入 backend 文件夹，将 config.sample.json 重命名为 config.json
```bash
cd etc/backend
cp config.sample.json config.json
```

4. 进入 judge 文件夹，将 config.sample.json 重命名为 config.json
Edit judger/etc/config.json and compile.json to your environment settings
```text
# judge.conf
cd judge/etc
cp config.sample.json config.json
```

5. 创建 `data` 文件夹，或将其他目录下的 `data` 文件夹软连接到 `judge/data`
```bash
# make dir
mkdir -p ./judger/data
# link
ln -s path/to/data ./judger/data
```

6. 启动容器:
```bash
docker-compose up -d
```