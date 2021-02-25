FROM debian:latest
MAINTAINER Liu Chaoyang <chaoyanglius@gmail.com>

RUN apt-get update && \
        apt-get -y install git make gcc unzip lua5.1 lua5.1-dev wait-for-it curl
        
RUN curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.deb.sh | bash && \
    apt-get -y install sysbench && apt-get clean && \
    curl -O https://luarocks.github.io/luarocks/releases/luarocks-2.4.3.tar.gz && \
    tar zxpf luarocks-2.4.3.tar.gz && cd luarocks-2.4.3 && ./configure && make bootstrap && \
    rm -rf luarocks-2.4.3.tar.gz

COPY entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh; ln -s /usr/local/bin/entrypoint.sh / # backwards compat

ENTRYPOINT ["entrypoint.sh"]
