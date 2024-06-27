FROM openresty/openresty:alpine

RUN apk add --no-cache wget build-base \
    && cd /usr/local/src \
    && wget https://github.com/maxmind/libmaxminddb/releases/download/1.10.0/libmaxminddb-1.10.0.tar.gz \
    && tar -zxf libmaxminddb-1.10.0.tar.gz \
    && cd libmaxminddb-1.10.0.tar.gz \
    && ./configure \
    && make && make install \
    && echo /usr/local/lib >> /etc/ld.so.conf.d/local.conf \
    && ldconfig \
    && cd /usr/local/src \
    && rm -rf libmaxminddb-1.10.0 libmaxminddb-1.10.0.tar.gz