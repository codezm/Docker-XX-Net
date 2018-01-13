# 主要特性
镜像基于 `debian:jessie` 创建, 由 `supervisord` 守护运行 `XX-Net` + `miredo` (开启ipv6 - 基于ipv4通道).

## 配置:

#### 自定义个人Appid, 修改以下文件中 `gae` 模块 `appid` (e.g. appid = abc|cba123|aaa)
    vim conf/xxnet/gae_proxy/manual.ini
#### 自定义个人 x_tunnel 账户信息
    vim conf/xxnet/x_tunnel/client.json

## Start with docker file:
- 创建镜像

      docker build -t xxnet
- 创建容器并后台运行服务

      docker run -it --rm --sysctl net.ipv6.conf.all.disable_ipv6=0 -p "8085:8085" -p "8086:8086" -p "8087:8087" -p "1080:1080" --name=xxnet -d --privileged xxnet
- 进入容器

      docker exec -it xxnet /bin/bash
## Start with docker-compose:
- 启动

      docker-compose up -d
- 进入容器

      docker exec -it xxnet /bin/bash
# 疑难问题:
- 若提示 `请检查浏览器代理设置`, 主机需下载安装并 **完全信任** 证书(可访问[此处](http://127.0.0.1:8085/)并在 `CA证书状态` 处下载证书).

# 帮助 [XX-Net](https://github.com/XX-net/XX-Net) 项目
https://github.com/XX-net/XX-Net/wiki/How-to-contribute
