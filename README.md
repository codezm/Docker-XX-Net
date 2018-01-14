## 主要特性
- 镜像基于 `debian:jessie` 创建, 由 `supervisord` 守护运行 `XX-Net` + `miredo` (开启ipv6 - 基于ipv4通道).
- 可随意更换 `XX-Net` 版本.

## 使用
## Docker Hub 「 推荐 」
    docker pull codezm/xx-net

## 自定义之 Dockerfile:
- 创建镜像

      docker build -t xxnet
- 创建容器并后台运行服务

      docker run -it --rm --sysctl net.ipv6.conf.all.disable_ipv6=0 -p "8085:8085" -p "8086:8086" -p "8087:8087" -p "1080:1080" --name=xxnet -d --privileged xxnet
- 进入容器

      docker exec -it xxnet /bin/bash

## 自定义之 Docker-compose:
- 启动

      docker-compose up -d
- 进入容器

      docker exec -it xxnet /bin/bash
## 疑难问题:
- 若提示 `请检查浏览器代理设置`, 主机需下载安装并 **完全信任** 证书(可访问 http://127.0.0.1:8085/ 在 `CA证书状态` 处下载证书).

## 帮助 [XX-Net](https://github.com/XX-net/XX-Net) 项目
https://github.com/XX-net/XX-Net/wiki/How-to-contribute
