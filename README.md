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

## Translation
[中文](/README.zh-cn.md)

## Requirements
Install [Docker](https://get.docker.com/) and [Docker Compose](https://docs.docker.com/compose/install/)

[Manual](/docs/INSTALL_DOCKER.md)

## Build args used by Dockerfiles
- `JUDGER_REPO` (default: `https://github.com/CUP-ACM-Programming-Club/CUP-Online-Judge-Judger.git`)
- `JUDGER_REF` (default: `master`)
- `DAEMON_REPO` (default: `https://github.com/ryanlee2014/CUP-Online-Judge-Judge-Daemon-Service.git`)
- `DAEMON_REF` (default: `master`)
- `NODE_MAJOR` (default: `24 22 20`)
- `NODE_MAJOR_LIST` (alias of `NODE_MAJOR`, retained for compatibility)
- `KOTLIN_NATIVE_VERSION` / `KOTLIN_NATIVE_SHA256`
- `KOTLIN_COMPILER_VERSION` / `KOTLIN_COMPILER_SHA256`

### Build strategy and reproducibility
All build args can be overridden in CI or local `docker build` commands to pin external inputs when needed.  
Recommended pattern for a pinned release:
`--build-arg JUDGER_REF=<commit_sha>`
`--build-arg DAEMON_REF=<commit_sha>`
`--build-arg NODE_MAJOR=24`
`--build-arg KOTLIN_NATIVE_SHA256=<sha256>`
`--build-arg KOTLIN_COMPILER_SHA256=<sha256>`

The `KOTLIN_*_SHA256` arguments are optional. Set them when you need deterministic artifacts; otherwise build still follows latest compatible upstream releases.

## Usage(all in one)
```bash
./init-env.sh
```

## Update(all in one)
```bash
./update.sh
```

## Usage(Manual Installation Guide)
1. Clone repo inside your project
```bash
git clone --recursive https://github.com/ryanlee2014/CUP-Online-Judge-NG-Docker-Judger.git docker-judger
```

2. Enter the folder and rename .env.example to .env, docker-compose.example.yml to docker-compose.yml
```bash
cd docker-judger
cp .env.example .env
cp docker-compose.example.xml docker.compose.yml
```

3. Enter the backend folder and rename config.sample.json to config.json
```bash
cd etc/backend
cp config.sample.json config.json
```

4. Enter the judge folder and rename config.sample.json to config.json
Edit judger/etc/config.json and compile.json to your environment settings
```text
# judge.conf
cd judge/etc
cp config.sample.json config.json
```

5. Make `data` foler and move files into the folder or link `data` folder to `judge/data`
```bash
# make dir
mkdir -p ./judger/data
# link
ln -s path/to/data ./judger/data
```

6. Run your containers:
```bash
docker-compose up -d
```

## Supporting CUP Online Judge
[Become a sponsor on afdian](https://afdian.net/@ryanlee) (Alipay only)
