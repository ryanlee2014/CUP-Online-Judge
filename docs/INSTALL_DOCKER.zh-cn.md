# 安装必要的Docker依赖

## 多语言
[English](/docs/INSTALL_DOCKER.md)

## Linux(Ubuntu)
1. 安装必要的Linux依赖软件
```bash
sudo apt-get update && sudo apt-get install -y vim python-pip curl git
pip install docker-compose
```

2. 安装Docker软件

* 中国大陆用户使用的安装命令:
```bash
sudo curl -sSL https://get.daocloud.io/docker | sh
```
* 其他国家和地区使用的安装命令:
```bash
sudo curl -sSL get.docker.com | sh
```

## macOS
1. 安装 Homebrew
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

2. 安装 docker 和 docker-compose
```bash
brew cask install docker
```

## Windows(**不建议**)
[Google](https://www.google.com)Lol

## 可复现构建参数
在 CI 或本地手动构建镜像时，可通过以下参数固定外部依赖：

- `JUDGER_REPO` / `JUDGER_REF`
- `DAEMON_REPO` / `DAEMON_REF`
- `NODE_MAJOR` / `NODE_MAJOR_LIST`（回退顺序，默认 `24 22 20 18 16 14`）
- `KOTLIN_NATIVE_VERSION` / `KOTLIN_NATIVE_SHA256`
- `KOTLIN_COMPILER_VERSION` / `KOTLIN_COMPILER_SHA256`

示例：

```bash
docker build \
  --build-arg JUDGER_REF=<commit_sha> \
  --build-arg DAEMON_REF=<commit_sha> \
  --build-arg NODE_MAJOR="24 22 20 18 16 14" \
  --build-arg KOTLIN_NATIVE_SHA256=<sha256> \
  --build-arg KOTLIN_COMPILER_SHA256=<sha256> \
  -f docker/judger/base/Dockerfile .
```

需要严格复现时，建议固定 `*_REF` 和对应的 `*_SHA256` 后再重试构建。
