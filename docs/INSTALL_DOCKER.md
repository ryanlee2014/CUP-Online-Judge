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

## Docker build reproducibility notes
The repository Dockerfiles used in CI expose build args for source pinning and optional checksum verification:
`JUDGER_REPO`, `JUDGER_REF`, `DAEMON_REPO`, `DAEMON_REF`, `NODE_MAJOR_LIST`,
`KOTLIN_NATIVE_VERSION`/`KOTLIN_NATIVE_SHA256`, `KOTLIN_COMPILER_VERSION`/`KOTLIN_COMPILER_SHA256`.

### Build argument strategy for safer CI
If you want deterministic CI output, pin upstream checkouts and checksums explicitly:

- `--build-arg JUDGER_REF=<commit_sha>`
- `--build-arg DAEMON_REF=<commit_sha>`
- `--build-arg NODE_MAJOR=<major_version>`
- `--build-arg NODE_MAJOR_LIST=<major list>` (defaults to `NODE_MAJOR`, kept for compatibility)
- `NODE_MAJOR`/`NODE_MAJOR_LIST` is attempted left-to-right; the first major version that can successfully install and complete `npm run build:main -- --skipLibCheck` is used.
- `--build-arg KOTLIN_NATIVE_SHA256=<sha256>`
- `--build-arg KOTLIN_COMPILER_SHA256=<sha256>`

If no checksum is provided, the build will continue with latest upstream-shared tarball metadata, which keeps CI aligned with LTS point releases.
