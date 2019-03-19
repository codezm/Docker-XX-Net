FROM debian:jessie

# Defined XX_Net Version.
ARG XX_NET_VERSION="3.13.1"
ARG XX_NET_SHA1="e77b20a72404f44c5cb3a142083f7d7cbd961530"

RUN set -ex; \
    { \
        echo 'deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib'; \
        echo 'deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib'; \
        echo 'deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib'; \
        echo 'deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib'; \
    } | tee /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y locales miredo net-tools python-pip wget vim \
    && mkdir -p /data/xxnet \
    && wget -c -O /data/xxnet.tar.gz "https://codeload.github.com/XX-net/XX-Net/tar.gz/$XX_NET_VERSION"; \
    if [ -n "$XX_NET_SHA1" ]; then \
        echo "$XX_NET_SHA1 /data/xxnet.tar.gz" | sha1sum -c -; \
    fi \
    && tar -xf /data/xxnet.tar.gz -C /data/xxnet --strip-components=1 \
    && rm -f /data/xxnet.tar.gz \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && pip install supervisor

COPY conf/xxnet/gae_proxy/config.json /data/xxnet/data/gae_proxy/config.json
COPY conf/xxnet/launcher/config.yaml /data/xxnet/data/launcher/config.yaml
COPY conf/xxnet/x_tunnel/client.json /data/xxnet/data/x_tunnel/client.json
COPY conf/supervisord/supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
