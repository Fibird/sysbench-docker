FROM debian:10.0
MAINTAINER Liu Chaoyang <chaoyanglius@gmail.com>

RUN apt-get update && \
        apt-get -y install sysbench git make gcc unzip lua5.1 lua5.1-dev wait-for-it && \
        apt-get clean
        
RUN curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.deb.sh | bash && \
    curl -O https://luarocks.org/releases/luarocks-2.4.3.tar.gz && \
    tar zxpf luarocks-2.4.3.tar.gz && cd luarocks-2.4.3 && ./configure && make bootstrap && \
    rm -rf luarocks-2.4.3.tar.gz

COPY entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh; ln -s /usr/local/bin/entrypoint.sh / # backwards compat

ENTRYPOINT ["entrypoint.sh"]
