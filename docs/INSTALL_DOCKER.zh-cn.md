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