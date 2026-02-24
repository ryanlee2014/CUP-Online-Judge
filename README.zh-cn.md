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
|[ryanlee2014/cupoj-language-server](https://hub.docker.com/r/ryanlee2014/cupoj-language-server)|![Pulls Count](https://img.shields.io/docker/pulls/ryanlee2014/cupoj-language-server)|![GitHub release (latest by date)](https://img.shields.io/github/v/tag/ryanlee2014/CUPOJ-Language-Server)|![Layers](https://shields.beevelop.com/docker/image/layers/ryanlee2014/cupoj-language-server/latest.svg)|![image size](https://img.shields.io/docker/image-size/ryanlee2014/cupoj-language-server)|
|[ryanlee2014/cupoj-frontend](https://github.com/ryanlee2014/CUP-Online-Judge-Frontend)|![GitHub commit activity](https://img.shields.io/github/commit-activity/w/ryanlee2014/CUP-Online-Judge-Frontend)|![GitHub release (latest by date)](https://img.shields.io/github/v/tag/ryanlee2014/CUP-Online-Judge-Frontend)||![GitHub repo size](https://img.shields.io/github/repo-size/ryanlee2014/CUP-Online-Judge-CDN)|
|[metowolf/nginx](https://hub.docker.com/r/metowolf/nginx)|![Pulls Count](https://img.shields.io/docker/pulls/metowolf/nginx.svg)|![GitHub release (latest by date)](https://img.shields.io/github/v/tag/metowolf/docker-nginx)|![](https://shields.beevelop.com/docker/image/layers/metowolf/nginx/latest.svg)|![](https://shields.beevelop.com/docker/image/image-size/metowolf/nginx/latest.svg)|
|[mysql/mysql-server](https://hub.docker.com/r/mysql/mysql-server)|![Pulls Count](https://img.shields.io/docker/pulls/mysql/mysql-server.svg)||![](https://shields.beevelop.com/docker/image/layers/mysql/mysql-server/latest.svg)|![](https://shields.beevelop.com/docker/image/image-size/mysql/mysql-server/latest.svg)|
|[library/redis](https://hub.docker.com/_/redis)|![Pulls Count](https://img.shields.io/docker/pulls/library/redis.svg)||![](https://shields.beevelop.com/docker/image/layers/library/redis/alpine.svg)|![](https://shields.beevelop.com/docker/image/image-size/library/redis/alpine.svg)|

## 运行要求
安装 [Docker](https://get.docker.com/) and [Docker Compose](https://docs.docker.com/compose/install/)

[安装手册](/docs/INSTALL_DOCKER.zh-cn.md)

## Docker 构建参数
- `JUDGER_REPO`（默认：`https://github.com/CUP-ACM-Programming-Club/CUP-Online-Judge-Judger.git`）
- `JUDGER_REF`（默认：`master`）
- `DAEMON_REPO`（默认：`https://github.com/ryanlee2014/CUP-Online-Judge-Judge-Daemon-Service.git`）
- `DAEMON_REF`（默认：`master`）
- `NODE_MAJOR`（默认：`24 22 20 18 16 14`）
- `NODE_MAJOR_LIST`（兼容 `NODE_MAJOR`）
- `NODE_MAJOR` / `NODE_MAJOR_LIST` 会按从左到右顺序尝试，使用第一个可以成功安装并通过 `npm run build:main -- --skipLibCheck` 的版本。
- `KOTLIN_NATIVE_VERSION` / `KOTLIN_NATIVE_SHA256`
- `KOTLIN_COMPILER_VERSION` / `KOTLIN_COMPILER_SHA256`

### 构建策略与可复现性
构建参数可在 CI 或本地 `docker build` 时覆盖，用于固定外部依赖版本。  
建议固定版本时使用：
`--build-arg JUDGER_REF=<commit_sha>`
`--build-arg DAEMON_REF=<commit_sha>`
`--build-arg NODE_MAJOR="24 22 20 18 16 14"`
`--build-arg KOTLIN_NATIVE_SHA256=<sha256>`
`--build-arg KOTLIN_COMPILER_SHA256=<sha256>`

`KOTLIN_*_SHA256` 为可选参数。需要严格复现时请填写对应哈希，平时可保持默认以跟随上游更新。

### 什么场景下建议固定版本
- CI 回退、发布复核：固定 `*_REF` 与 `KOTLIN_*_SHA256`。
- 上游改动导致构建失败：先固定 `NODE_MAJOR` / `NODE_MAJOR_LIST`、`NODEJS_SHA256` 和 git ref 重试。
- 跨区域/离线复现：固定 `KOTLIN_NATIVE_VERSION` 与 `KOTLIN_COMPILER_VERSION`，并与 SHA 一并固定。

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

## 支持 CUP Online Judge
[在爱发电成为赞助商](https://afdian.net/@ryanlee)(仅支持支付宝)
