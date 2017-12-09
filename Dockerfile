FROM debian:jessie

RUN { \
    echo 'deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib'; \
    echo 'deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib'; \
    echo 'deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib'; \
    echo 'deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib'; \
    } | tee /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y locales miredo net-tools vim python-pip && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    pip install supervisor

COPY data/XX-Net-3.8.5/ /data/xxnet/
COPY conf/gae_proxy/manual.ini /data/xxnet/data/gae_proxy/manual.ini
COPY conf/launcher/config.yaml /data/xxnet/data/launcher/config.yaml
COPY conf/x_tunnel/client.json /data/xxnet/data/x_tunnel/client.json
COPY conf/supervisord/supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
