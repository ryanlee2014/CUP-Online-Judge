# Install docker and etc.

## Translation
[中文](/docs/INSTALL_DOCKER.zh-cn.md)

## Linux(Ubuntu)
1. Install necessary linux dependencies.
```bash
sudo apt-get update && sudo apt-get install -y vim python-pip curl git
pip install docker-compose
```

2. Install docker

* Install command for Mainland China users:
```bash
sudo curl -sSL https://get.daocloud.io/docker | sh
```
* Other countries and regions:
```bash
sudo curl -sSL get.docker.com | sh
```

## macOS
1. Install Homebrew
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

2. Install docker with docker-compose
```bash
brew cask install docker
```

## Windows(**Strongly not recommended**)
[Google](https://www.google.com)Lol