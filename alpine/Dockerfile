# Dockerfile - alpine
# https://github.com/openresty/docker-openresty

ARG RESTY_IMAGE_BASE="alpine"
ARG RESTY_IMAGE_TAG="3.21.3"

FROM ${RESTY_IMAGE_BASE}:${RESTY_IMAGE_TAG}

LABEL maintainer="Evan Wies <evan@neomantra.net>"

# Docker Build Arguments
ARG RESTY_IMAGE_BASE="alpine"
ARG RESTY_IMAGE_TAG="3.21.3"
ARG RESTY_VERSION="1.27.1.2"

# https://github.com/openresty/openresty-packaging/blob/master/alpine/openresty-openssl3/APKBUILD
ARG RESTY_OPENSSL_VERSION="3.4.1"
ARG RESTY_OPENSSL_PATCH_VERSION="3.4.1"
ARG RESTY_OPENSSL_URL_BASE="https://github.com/openssl/openssl/releases/download/openssl-${RESTY_OPENSSL_VERSION}"
# LEGACY:  "https://www.openssl.org/source/old/1.1.1"
ARG RESTY_OPENSSL_BUILD_OPTIONS="enable-camellia enable-seed enable-rfc3779 enable-cms enable-md2 enable-rc5 \
        enable-weak-ssl-ciphers enable-ssl3 enable-ssl3-method enable-md2 enable-ktls enable-fips \
        "

# https://github.com/openresty/openresty-packaging/blob/master/alpine/openresty-pcre2/APKBUILD
ARG RESTY_PCRE_VERSION="10.44"
ARG RESTY_PCRE_SHA256="86b9cb0aa3bcb7994faa88018292bc704cdbb708e785f7c74352ff6ea7d3175b"
ARG RESTY_PCRE_BUILD_OPTIONS="--enable-jit --enable-pcre2grep-jit --disable-bsr-anycrlf --disable-coverage --disable-ebcdic --disable-fuzz-support \
    --disable-jit-sealloc --disable-never-backslash-C --enable-newline-is-lf --enable-pcre2-8 --enable-pcre2-16 --enable-pcre2-32 \
    --enable-pcre2grep-callout --enable-pcre2grep-callout-fork --disable-pcre2grep-libbz2 --disable-pcre2grep-libz --disable-pcre2test-libedit \
    --enable-percent-zt --disable-rebuild-chartables --enable-shared --disable-static --disable-silent-rules --enable-unicode --disable-valgrind \
    "

ARG RESTY_J="1"

# https://github.com/openresty/openresty-packaging/blob/master/alpine/openresty/APKBUILD
ARG RESTY_CONFIG_OPTIONS="\
    --with-compat \
    --without-http_rds_json_module \
    --without-http_rds_csv_module \
    --without-lua_rds_parser \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module \
    --with-http_addition_module \
    --with-http_auth_request_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_geoip_module=dynamic \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_image_filter_module=dynamic \
    --with-http_mp4_module \
    --with-http_random_index_module \
    --with-http_realip_module \
    --with-http_secure_link_module \
    --with-http_slice_module \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_sub_module \
    --with-http_v2_module \
    --with-http_v3_module \
    --with-http_xslt_module=dynamic \
    --with-ipv6 \
    --with-mail \
    --with-mail_ssl_module \
    --with-md5-asm \
    --with-sha1-asm \
    --with-stream \
    --with-stream_ssl_module \
    --with-stream_ssl_preread_module \
    --with-threads \
    "
ARG RESTY_CONFIG_OPTIONS_MORE=""
ARG RESTY_LUAJIT_OPTIONS="--with-luajit-xcflags='-DLUAJIT_NUMMODE=2 -DLUAJIT_ENABLE_LUA52COMPAT'"
ARG RESTY_PCRE_OPTIONS="--with-pcre-jit"

ARG RESTY_ADD_PACKAGE_BUILDDEPS=""
ARG RESTY_ADD_PACKAGE_RUNDEPS=""
ARG RESTY_EVAL_PRE_CONFIGURE=""
ARG RESTY_EVAL_POST_DOWNLOAD_PRE_CONFIGURE=""
ARG RESTY_EVAL_PRE_MAKE=""
ARG RESTY_EVAL_POST_MAKE=""

ARG RESTY_STRIP_BINARIES=""

# These are not intended to be user-specified
ARG _RESTY_CONFIG_DEPS="--with-pcre \
    --with-cc-opt='-DNGX_LUA_ABORT_AT_PANIC -I/usr/local/openresty/pcre2/include -I/usr/local/openresty/openssl3/include' \
    --with-ld-opt='-L/usr/local/openresty/pcre2/lib -L/usr/local/openresty/openssl3/lib -Wl,-rpath,/usr/local/openresty/pcre2/lib:/usr/local/openresty/openssl3/lib' \
    "

LABEL resty_image_base="${RESTY_IMAGE_BASE}"
LABEL resty_image_tag="${RESTY_IMAGE_TAG}"
LABEL resty_version="${RESTY_VERSION}"
LABEL resty_openssl_version="${RESTY_OPENSSL_VERSION}"
LABEL resty_openssl_patch_version="${RESTY_OPENSSL_PATCH_VERSION}"
LABEL resty_openssl_url_base="${RESTY_OPENSSL_URL_BASE}"
LABEL resty_openssl_build_options="${RESTY_OPENSSL_BUILD_OPTIONS}"
LABEL resty_pcre_version="${RESTY_PCRE_VERSION}"
LABEL resty_pcre_build_options="${RESTY_PCRE_BUILD_OPTIONS}"
LABEL resty_pcre_sha256="${RESTY_PCRE_SHA256}"
LABEL resty_config_options="${RESTY_CONFIG_OPTIONS}"
LABEL resty_config_options_more="${RESTY_CONFIG_OPTIONS_MORE}"
LABEL resty_config_deps="${_RESTY_CONFIG_DEPS}"
LABEL resty_add_package_builddeps="${RESTY_ADD_PACKAGE_BUILDDEPS}"
LABEL resty_add_package_rundeps="${RESTY_ADD_PACKAGE_RUNDEPS}"
LABEL resty_eval_pre_configure="${RESTY_EVAL_PRE_CONFIGURE}"
LABEL resty_eval_post_download_pre_configure="${RESTY_EVAL_POST_DOWNLOAD_PRE_CONFIGURE}"
LABEL resty_eval_pre_make="${RESTY_EVAL_PRE_MAKE}"
LABEL resty_eval_post_make="${RESTY_EVAL_POST_MAKE}"
LABEL resty_strip_binaries="${RESTY_STRIP_BINARIES}"
LABEL resty_luajit_options="${RESTY_LUAJIT_OPTIONS}"
LABEL resty_pcre_options="${RESTY_PCRE_OPTIONS}"

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        binutils \
        coreutils \
        curl \
        gd-dev \
        geoip-dev \
        libxslt-dev \
        linux-headers \
        make \
        perl-dev \
        readline-dev \
        zlib-dev \
        ${RESTY_ADD_PACKAGE_BUILDDEPS} \
    && apk add --no-cache \
        gd \
        geoip \
        libgcc \
        libxslt \
        tzdata \
        zlib \
        ${RESTY_ADD_PACKAGE_RUNDEPS} \
    && cd /tmp \
    && if [ -n "${RESTY_EVAL_PRE_CONFIGURE}" ]; then eval $(echo ${RESTY_EVAL_PRE_CONFIGURE}); fi \
    && cd /tmp \
    && curl -fSL "${RESTY_OPENSSL_URL_BASE}/openssl-${RESTY_OPENSSL_VERSION}.tar.gz" -o openssl-${RESTY_OPENSSL_VERSION}.tar.gz \
    && tar xzf openssl-${RESTY_OPENSSL_VERSION}.tar.gz \
    && cd openssl-${RESTY_OPENSSL_VERSION} \
    && if [ $(echo ${RESTY_OPENSSL_VERSION} | cut -c 1-2) = "3." ] ; then \
        echo 'patching OpenSSL 3.x for OpenResty' \
        && curl -s https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-${RESTY_OPENSSL_PATCH_VERSION}-sess_set_get_cb_yield.patch | patch -p1 ; \
    fi \
    && if [ $(echo ${RESTY_OPENSSL_VERSION} | cut -c 1-5) = "1.1.1" ] ; then \
        echo 'patching OpenSSL 1.1.1 for OpenResty' \
        && curl -s https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-${RESTY_OPENSSL_PATCH_VERSION}-sess_set_get_cb_yield.patch | patch -p1 ; \
    fi \
    && if [ $(echo ${RESTY_OPENSSL_VERSION} | cut -c 1-5) = "1.1.0" ] ; then \
        echo 'patching OpenSSL 1.1.0 for OpenResty' \
        && curl -s https://raw.githubusercontent.com/openresty/openresty/ed328977028c3ec3033bc25873ee360056e247cd/patches/openssl-1.1.0j-parallel_build_fix.patch | patch -p1 \
        && curl -s https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-${RESTY_OPENSSL_PATCH_VERSION}-sess_set_get_cb_yield.patch | patch -p1 ; \
    fi \
    && ./config \
      shared zlib -g \
      --prefix=/usr/local/openresty/openssl3 \
      --libdir=lib \
      -Wl,-rpath,/usr/local/openresty/openssl3/lib \
      ${RESTY_OPENSSL_BUILD_OPTIONS} \
    && make -j${RESTY_J} \
    && make -j${RESTY_J} install_sw \
    && cd /tmp \
    && curl -fSL "https://github.com/PCRE2Project/pcre2/releases/download/pcre2-${RESTY_PCRE_VERSION}/pcre2-${RESTY_PCRE_VERSION}.tar.gz" -o pcre2-${RESTY_PCRE_VERSION}.tar.gz \
    && echo "${RESTY_PCRE_SHA256}  pcre2-${RESTY_PCRE_VERSION}.tar.gz" | shasum -a 256 --check \
    && tar xzf pcre2-${RESTY_PCRE_VERSION}.tar.gz \
    && cd /tmp/pcre2-${RESTY_PCRE_VERSION} \
    && CFLAGS="-g -O3" ./configure \
        --prefix=/usr/local/openresty/pcre2 \
        --libdir=/usr/local/openresty/pcre2/lib \
        ${RESTY_PCRE_BUILD_OPTIONS} \
    && CFLAGS="-g -O3" make -j${RESTY_J} \
    && CFLAGS="-g -O3" make -j${RESTY_J} install \
    && cd /tmp \
    && curl -fSL https://openresty.org/download/openresty-${RESTY_VERSION}.tar.gz -o openresty-${RESTY_VERSION}.tar.gz \
    && tar xzf openresty-${RESTY_VERSION}.tar.gz \
    && cd /tmp/openresty-${RESTY_VERSION} \
    && mkdir -p modules \
    && curl -fSL https://github.com/nginx-modules/ngx_cache_purge/archive/refs/tags/2.5.3.tar.gz -o ./modules/ngx_cache_purge-2.5.3.tar.gz \
    && tar xzf ./modules/ngx_cache_purge-2.5.3.tar.gz -C ./modules \
    && rm -rf ./modules/ngx_cache_purge-2.5.3.tar.gz \
    && curl -fSL https://github.com/google/ngx_brotli/archive/refs/heads/master.tar.gz -o ./modules/ngx_brotli.tar.gz \
    && tar xzf ./modules/ngx_brotli.tar.gz -C ./modules \
    && rm -rf ./modules/ngx_brotli.tar.gz \
    && curl -fSL https://github.com/google/brotli/archive/ed738e842d2fbdf2d6459e39267a633c4a9b2f5d.tar.gz -o ./modules/ngx_brotli_deps.tar.gz \
    && tar xzf ./modules/ngx_brotli_deps.tar.gz -C ./modules/ngx_brotli-master/deps/brotli --strip-components=1 \
    && rm -rf ./modules/ngx_brotli_deps.tar.gz \
    && if [ -n "${RESTY_EVAL_POST_DOWNLOAD_PRE_CONFIGURE}" ]; then eval $(echo ${RESTY_EVAL_POST_DOWNLOAD_PRE_CONFIGURE}); fi \
    && eval ./configure -j${RESTY_J} ${_RESTY_CONFIG_DEPS} ${RESTY_CONFIG_OPTIONS} ${RESTY_CONFIG_OPTIONS_MORE} ${RESTY_LUAJIT_OPTIONS} ${RESTY_PCRE_OPTIONS} \
    --add-module=./modules/ngx_cache_purge-2.5.3 \
    --add-module=./modules/ngx_brotli-master \
    && if [ -n "${RESTY_EVAL_PRE_MAKE}" ]; then eval $(echo ${RESTY_EVAL_PRE_MAKE}); fi \
    && make -j${RESTY_J} \
    && make -j${RESTY_J} install \
    && cd /tmp \
    && if [ -n "${RESTY_EVAL_POST_MAKE}" ]; then eval $(echo ${RESTY_EVAL_POST_MAKE}); fi \
    && rm -rf \
        openssl-${RESTY_OPENSSL_VERSION}.tar.gz openssl-${RESTY_OPENSSL_VERSION} \
        pcre2-${RESTY_PCRE_VERSION}.tar.gz pcre2-${RESTY_PCRE_VERSION} \
        openresty-${RESTY_VERSION}.tar.gz openresty-${RESTY_VERSION} \
    && if [ -n "${RESTY_STRIP_BINARIES}" ]; then \
        echo 'stripping OpenResty binaries' \
        && rm -Rf /usr/local/openresty/openssl3/bin/c_rehash /usr/local/openresty/openssl3/lib/*.a /usr/local/openresty/openssl3/include \
        && find /usr/local/openresty/openssl3 -type f -perm -u+x -exec strip --strip-unneeded '{}' \; \
        && rm -Rf /usr/local/openresty/pcre2/bin /usr/local/openresty/pcre2/share \
        && find /usr/local/openresty/pcre2 -type f -perm -u+x -exec strip --strip-unneeded '{}' \; \
        && rm -Rf /usr/local/openresty/luajit/lib/*.a /usr/local/openresty/luajit/share/man \
        && find /usr/local/openresty/luajit -type f -perm -u+x -exec strip --strip-unneeded '{}' \; \
        && find /usr/local/openresty/nginx -type f -perm -u+x -exec strip --strip-unneeded '{}' \; ; \ 
    fi \
    && apk del .build-deps \
    && mkdir -p /var/run/openresty \
    && ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log \
    && ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

# Add additional binaries into PATH for convenience
ENV PATH=$PATH:/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin

# Copy nginx configuration files
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]

# Use SIGQUIT instead of default SIGTERM to cleanly drain requests
# See https://github.com/openresty/docker-openresty/blob/master/README.md#tips--pitfalls
STOPSIGNAL SIGQUIT
