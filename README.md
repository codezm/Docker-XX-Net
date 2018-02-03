## 主要特性 [![Build Status](https://travis-ci.org/codezm/Docker-XX-Net.svg?branch=master)](https://travis-ci.org/codezm/Docker-XX-Net)
- 镜像基于 `debian:jessie` 创建, 由 `supervisord` 守护运行 `XX-Net` + `miredo` (开启ipv6 - 基于ipv4通道)。
- 可随意更换 `XX-Net` 版本。

## 使用
### Docker Hub 「 推荐 」
```bash
docker pull codezm/xxnet
```

### 自定义之 Dockerfile:
```bash
# 创建镜像
docker build -t xxnet
# 创建容器并后台运行服务
docker run -itd \
           --rm \
           --sysctl net.ipv6.conf.all.disable_ipv6=0 \
           --privileged \
           --name=xxnet \
           -p "8085:8085" \
           -p "8086:8086" \
           -p "8087:8087" \
           -p "1080:1080" \
           -v "$(pwd)/conf/supervisord/supervisord.conf:/etc/supervisord.conf" \
           -v "$(pwd)/conf/xxnet/gae_proxy/manual.ini:/data/xxnet/data/gae_proxy/manual.ini" \
           -v "$(pwd)/conf/xxnet/launcher/config.yaml:/data/xxnet/data/launcher/config.yaml" \
           -v "$(pwd)/conf/xxnet/x_tunnel/client.json:/data/xxnet/data/x_tunnel/client.json" \
           xxnet
# 进入容器
docker exec -it xxnet /bin/bash
```

### 自定义之 Docker-compose:
```bash
# 启动
docker-compose up -d
# 进入容器
docker exec -it xxnet /bin/bash
```

## 主机导入 `CA.crt` - 由于每次创建容器 `CA.crt` 都会变动:
- 方式一：访问 http://127.0.0.1:8085/ 在 `CA证书状态` 处下载证书)。
- 方式二：通过 `docker cp xxnet:/data/xxnet/data/gae_proxy/CA.crt ./` 命令获取最后变动`CA.crt`文件。
## Chrome浏览器添加 `SwitchyOmega` 插件:
在当前目录下复制容器中插件及配置文件.
```bash
docker cp xxnet:/data/xxnet/SwitchyOmega/OmegaOptions.bak ./
docker cp xxnet:/data/xxnet/SwitchyOmega/SwitchyOmega.crx ./
```
详见[安装和使用代理切换插件](https://github.com/XX-net/XX-Net/wiki/%E4%BD%BF%E7%94%A8Chrome%E6%B5%8F%E8%A7%88%E5%99%A8#%E6%96%B9%E6%A1%88%E4%BA%8C%E5%AE%89%E8%A3%85%E5%92%8C%E4%BD%BF%E7%94%A8%E4%BB%A3%E7%90%86%E5%88%87%E6%8D%A2%E6%8F%92%E4%BB%B6)

## 疑难问题:
- 若提示 `请检查浏览器代理设置` 需确认 `CA.crt` 导入本机并已 **完全信任** 。


## 帮助 [XX-Net](https://github.com/XX-net/XX-Net) 项目
https://github.com/XX-net/XX-Net/wiki/How-to-contribute
