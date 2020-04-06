# ~~CUP-Online-Judge-NG-Docker-Judger~~CUPOJ

## 运行要求
安装 [Docker](https://get.docker.com/) and [Docker Compose](https://docs.docker.com/compose/install/)

## 使用方法(整合脚本)
```bash
./init_env.sh
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