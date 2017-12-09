# 主要特性
镜像基于 `debian:jessie` 创建, `supervisord` 运行 `XX-Net` 与 `miredo` 开启IPV6(基于ipv4通道).

## 使用

### 自定义配置
##### 定义个人Appid, 修改以下文件中 `gae` 模块 `appid` (e.g. appid = abc|cba123|aaa)
xxnet/conf/gae_proxy/manual.ini
##### 定义个人 x_tunnel 账户信息
xxnet/conf/x_tunnel/client.json

### Docker file

#### 创建镜像
docker build -t xxnet .
#### 创建容器并后台运行服务
docker run -it --rm --sysctl net.ipv6.conf.all.disable_ipv6=0 -p "8085:8085" -p "8087:8087" -p "1080:1080" --name=xxnet -d --privileged xxnet
#### 进入容器
docker exec -it xxnet /bin/bash

### Docker-compose
docker-compose up -d
#### 进入容器
docker exec -it xxnet /bin/bash

## 感谢
[XX-Net](https://github.com/XX-net/XX-Net)
