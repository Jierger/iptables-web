
# (Xiaomi Router 10000) iptables Management Web Service
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![GitHub go.mod Go version](https://img.shields.io/github/go-mod/go-version/pretty66/iptables-web)](https://github.com/pretty66/iptables-web/blob/master/go.mod)

### Overview
`iptables-web` is a lightweight web interface program designed for iptables management. It supports the direct execution of binary files and facilitates quick deployment and installation using Docker. The entire program, when packaged, comprises only a single binary file, making it highly suitable for routine operations and maintenance tasks.

![web](./docs/iptables-web.png)

## Contents
- [Docker Image](#docker-image)
- [Installation Guide](#installation-guide)
- [Licensing Information](#licensing-information)

## Docker Image

### Method: Pull Image

```shell
docker pull a00764599/iptables-web
```

### Method: Load Image
```shell
curl -L -o iptables-web_1.1.1.tar https://github.com/Jierger/iptables-web/releases/download/v1.1.1/iptables-web_1.1.1.tar
docker load < iptables-web_1.1.1.tar
```

### Method: Build Image
Source Code Get:

```shell
git clone https://github.com/Jierger/iptables-web.git
```
or
``` shell
wget -O iptables-web.zip  https://github.com/Jierger/iptables-web/archive/refs/heads/main.zip
```

#### Docker Build
Excludes cross-compilers, so commands need to be executed in the router system

```shell
cd iptables-web
docker build -t iptables-web:1.1.1 .
```

## Installation Guide
### Docker Deployment and Installation
When deploying with Docker, ensure to include two critical parameters: `--privileged` and `--net=host`. These allow the container to run in privileged mode, necessary for managing iptables rules on the host machine.

```shell
docker run -d \
  --name iptables-web \
  --privileged \
  --net=host \
  --cap-add SYS_MODULE \
  -e "IPT_WEB_USERNAME=admin" \
  -e "IPT_WEB_PASSWORD=admin" \
  -e "IPT_WEB_ADDRESS=:10001" \
  -v /usr/lib/iptables/libxt_flowMARK.so:/usr/lib/aarch64-linux-gnu/xtables/libxt_flowMARK.so \
  -v /usr/lib/iptables/libxt_IP4MARK.so:/usr/lib/aarch64-linux-gnu/xtables/libxt_IP4MARK.so \
  -v /usr/lib/iptables/libxt_cgroup_MARK.so:/usr/lib/aarch64-linux-gnu/xtables/libxt_cgroup_MARK.so: \
  -p 10001:10001 \
  a00764599/iptables-web:1.1.1
```
- `IPT_WEB_USERNAME`: Default web authorization username (default: `admin`)
- `IPT_WEB_PASSWORD`: Default web authorization password (default: `admin`)
- `IPT_WEB_ADDRESS`: Web interface port (default: `10001`)

### Licensing Information

`iptables-web` is distributed under the Apache 2.0 license. For more details, refer to the [LICENSE](./LICENSE) file.
