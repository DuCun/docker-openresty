# docker-openresty - Docker tooling for OpenResty

[![Travis Status](https://api.travis-ci.com/openresty/docker-openresty.svg?branch=master)](https://travis-ci.com/github/openresty/docker-openresty)  [![Appveyor status](https://ci.appveyor.com/api/projects/status/github/openresty/docker-openresty?branch=master&svg=true)](https://ci.appveyor.com/project/openresty/docker-openresty)  [![](https://images.microbadger.com/badges/image/openresty/openresty.svg)](https://microbadger.com/#/images/openresty/openresty "microbadger.com")

`docker-openresty` is [Docker](https://www.docker.com) tooling for OpenResty (https://www.openresty.org).

Docker is a container management platform. OpenResty is a full-fledged web application server by
bundling the standard nginx core, lots of 3rd-party nginx modules, as well as most of their external dependencies.

Thank you to [Travis CI](https://www.travis-ci.com) for donating their build infrastructure to this project for over seven years!

# OpenResty Image Tags

It is best practice to pin your images to an explicit image tag.  The [next section](#supported-tags-and-respective-dockerfile-links) below covers the conventions in detail, but here are some common examples:

| Image  | Description |
| --- | --- |
| `openresty/openresty:1.27.1.2-0-jammy` | Built-from-source Ubuntu Jammy |
| `openresty/openresty:1.27.1.2-0-focal` | Built-from-source Ubuntu Focal |
| `openresty/openresty:1.27.1.2-0-bookworm-fat` | Built-from-upstream Debian Bookworm |
| `openresty/openresty:1.27.1.2-0-alpine` | Built-from-source Alpine |
| `openresty/openresty:1.27.1.2-0-alpine-apk` | Built-from-upstream Alpine |

These are examples of untagged image names, for reference:

| Image | Description |
| --- | --- |
| `openresty/openresty:noble` | Latest Ubuntu Noble |
| `openresty/openresty:jammy` | Latest Ubuntu Jammy |
| `openresty/openresty:alpine` | Latest Alpine |

There are also specific tags for [Debug](https://openresty.org/en/deb-packages.html#openresty-debug) and [Valgrind](https://openresty.org/en/deb-packages.html#openresty-valgrind) OpenResty variants:
| Image | Description |
| --- | --- |
| `openresty/openresty:bullseye-debug` | Bullseye flavor with `openresty-debug` |
| `openresty/openresty:bullseye-valgrind` | Bullseye flavor with `openresty-valgrind` |
| `openresty/openresty:bullseye-fat-debug` | Bullseye FAT flavor with `openresty-debug` |
| `openresty/openresty:bullseye-fat-valgrind` | Bullseye FAT flavor with `openresty-valgrind` |

As of `1.27.1.2-1`, we also mirror to the GitHub Container Registry.  Simply prefix the registry path with `ghcr.io/`:

 * `ghcr.io/openresty/openresty:1.27.1.2-1-bullseye`

----

Table of Contents
=================

* [OpenResty Image Tags](#openresty-image-tags)
* [Table of Contents](#table-of-contents)
* [Usage](#usage)
* [Policies](#policies)
* [Nginx Config Files](#nginx-config-files)
* [OPM](#opm)
* [LuaRocks](#luarocks)
* [Tips & Pitfalls](#tips--pitfalls)
* [Image Labels](#image-labels)
* [Docker CMD](#docker-cmd)
* [Building (from source)](#building-from-source)
* [Building (RPM based)](#building-rpm-based)
* [Building (DEB based)](#building-deb-based)
* [Building (APK based)](#building-apk-based)
* [Building (Windows based)](#building-windows-based)
* [Feedback & Bug Reports](#feedback--bug-reports)
* [Changelog & Authors](#changelog--authors)
* [Copyright & License](#copyright--license)


Usage
=====

If you are happy with the build defaults, then you can use the openresty image from the [Docker Hub](https://hub.docker.com/r/openresty/openresty/).  The image tags available there are listed at the top of this README.

```
docker run [options] openresty/openresty:bullseye-fat
```

*[options]* would be things like -p to map ports, -v to map volumes, and -d to daemonize.

`docker-openresty` symlinks `/usr/local/openresty/nginx/logs/access.log` and `error.log` to `/dev/stdout` and `/dev/stderr` respectively, so that Docker logging works correctly.  If you change the log paths in your `nginx.conf`, you should symlink those paths as well. This is not possible with the `windows` image.

Temporary directories such as `client_body_temp_path` are stored in `/var/run/openresty/`.  You may consider mounting that volume, rather than writing to a container-local directory.  This is not done for `windows`.

Supported tags and respective `Dockerfile` links
=========

The following "flavors" are available and built from [upstream OpenResty packages](https://openresty.org/en/linux-packages.html):

- [`alpine-apk`, (*alpine-apk/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/alpine-apk/Dockerfile)
- [`amzn2`, (*centos/Dockerfile* with `amzn2`)](https://github.com/openresty/docker-openresty/blob/master/centos/Dockerfile)
- [`bookworm-buildpack`, (*bookworm/Dockerfile.buildpack*)](https://github.com/openresty/docker-openresty/blob/master/bookworm/Dockerfile.buildpack)
- [`bookworm-fat`, (*bookworm/Dockerfile.fat*)](https://github.com/openresty/docker-openresty/blob/master/bookworm/Dockerfile.fat)
- [`bookworm`, (*bookworm/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/bookworm/Dockerfile)
- [`bullseye-fat`, (*bullseye/Dockerfile.fat*)](https://github.com/openresty/docker-openresty/blob/master/bullseye/Dockerfile.fat)
- [`bullseye`, (*bullseye/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/bullseye/Dockerfile)
- [`centos`, `centos-rpm`, (*centos/Dockerfile* with `el8`)](https://github.com/openresty/docker-openresty/blob/master/centos/Dockerfile)
- [`centos7`, (*centos7/Dockerfile* with `el7`)](https://github.com/openresty/docker-openresty/blob/master/centos7/Dockerfile)
- [`fedora`, `fedora-rpm`, (*fedora/Dockerfile* with `fc36`)](https://github.com/openresty/docker-openresty/blob/master/fedora/Dockerfile)
- [`rocky`, (*fedora/Dockerfile* with `rockylinux`)](https://github.com/openresty/docker-openresty/blob/master/fedora/Dockerfile)
- [`windows`, (*windows/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/windows/Dockerfile)

The following "flavors" are built from source and are intended for more advanced and custom usage, caveat emptor:

- [`alpine-fat`, (*alpine/Dockerfile.fat*)](https://github.com/openresty/docker-openresty/blob/master/alpine/Dockerfile.fat)
- [`alpine`, (*alpine/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/alpine/Dockerfile)
- [`alpine-slim`, (*alpine/Dockerfile*](https://github.com/openresty/docker-openresty/blob/master/alpine/Dockerfile), stripped Alpine image)
- [`bionic`, (*bionic/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/bionic/Dockerfile)
- [`focal`, (*focal/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/focal/Dockerfile)
- [`jammy`, (*jammy/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/jammy/Dockerfile)
- [`noble`, (*noble/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/noble/Dockerfile)

The `openresty/openresty:latest` tag points to the latest `bookworm` image.

Since `1.19.3.2-1`, all flavors support multi-architecture builds, both `amd64` and `aarch64`.  Since `1.21.4.1-1`, the `s390x` architecture is supported for build-from-source Ubuntu flavors (like `jammy`), however [PCRE JIT](https://github.com/zherczeg/sljit/issues/89) is disabled.

Starting with `1.13.6.1`, releases are tagged with `<openresty-version>-<image-version>-<flavor>`.  The latest `image-version` will also be tagged `<openresty-version>-<flavor>`.   The HEAD of the master branch is also labeled plainly as `<flavor>`.  The builds are managed by [Travis-CI](https://travis-ci.com/github/neomantra/docker-openresty) and [Appveyor](https://ci.appveyor.com/project/openresty/docker-openresty) (for Windows images).

There are architecture-specific tags as well, `<openresty-version>-<image-version>-<flavor>-<arch>`, but one would generally pull from the multi-architecture name above.

OpenResty supports SSE 4.2 optimizations.  Starting with the `1.19.3.1` series, the architecture is auto-detected and the optimizations enabled accordingly.  Earlier image series `1.15.8.1` and `1.17.8.2` have `-nosse42` image flavors for systems which explicitly disable SSE 4.2 support; this is useful for older systems and embedded systems.  They are built with `-mno-sse4.2` appended to the build arg `RESTY_LUAJIT_OPTIONS`.  It is highly recommended *NOT* to use these if your system supports SSE 4.2 because the `CRC32` instruction dramatically improves large string performance.  These are only for built-from-source flavors, e.g. `1.15.8.1-3-bionic-nosse42`, `1.15.8.1-3-alpine-nosse42`, `1.15.8.1-3-alpine-fat-nosse42`.

It is *highly recommended* that you use the upstream-based images for best support.  For best stability, pin your images to the full tag, for example `1.21.4.1-0-bionic`.

Policies
========

The [Maintainers](#changelog--authors) of this OpenResty Docker Tooling operate under the following policies:

 * We track [OpenResty releases](https://openresty.org/en/linux-packages.html) for build-from-upstream and will continue to add new upstream releases:

    * [`alpine-apk`, (*alpine-apk/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/alpine-apk/Dockerfile)
    * [`amzn2`, (*centos/Dockerfile* with `amzn2`)](https://github.com/openresty/docker-openresty/blob/master/centos/Dockerfile)
    * [`bullseye-fat`, (*bullseye/Dockerfile.fat*)](https://github.com/openresty/docker-openresty/blob/master/bullseye/Dockerfile.fat)
    * [`bullseye`, (*bullseye/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/bullseye/Dockerfile)
    * [`centos`, `centos-rpm`, (*centos/Dockerfile* with `el8`)](https://github.com/openresty/docker-openresty/blob/master/centos/Dockerfile)
    * [`centos7`, (*centos7/Dockerfile* with `el7`)](https://github.com/openresty/docker-openresty/blob/master/centos7/Dockerfile)
    * [`fedora`, `fedora-rpm`, (*fedora/Dockerfile* with `fc36`)](https://github.com/openresty/docker-openresty/blob/master/fedora/Dockerfile)
    * [`rocky`, (*fedora/Dockerfile* with `rockylinux`)](https://github.com/openresty/docker-openresty/blob/master/fedora/Dockerfile)
    * [`windows`, (*windows/Dockerfile*)](https://github.com/openresty/docker-openresty/blob/master/windows/Dockerfile)

 * We track build-from-source images as follows:
 
    * [Alpine `stable`](https://www.alpinelinux.org/releases/)
    * [Ubuntu "LTS"](https://wiki.ubuntu.com/Releases)

 * We try to include popular architectures (`x86_64`, `aarch64`, `s390x`)

 * RC versions of upstream releases will be made available on tags

 * If an image fails CI/CD too much, we will remove it.

 * We operate in English and PRs must be English as well, unless for localization purposes.
 
 * We will accept issues in any language.  We will provide our translations to English for clarity.

 * All are welcome to particpate, but must show mutual respect to the community.

Nginx Config Files
==================

The Docker tooling installs its own [`nginx.conf` file](https://github.com/openresty/docker-openresty/blob/master/nginx.conf).  If you want to directly override it, you can replace it in your own Dockerfile or via volume bind-mounting.

For the Linux images, that `nginx.conf` has the directive `include /etc/nginx/conf.d/*.conf;` so all nginx configurations in that directory will be included.  The [default virtual host configuration](https://github.com/openresty/docker-openresty/blob/master/nginx.vh.default.conf) has the original OpenResty configuration and is copied to `/etc/nginx/conf.d/default.conf`.

Since `1.25.3.2-2`, the `nginx.conf` also contains `include /etc/nginx/conf.d/*.main;` at the `main` stanza level (rather than the `http` level of `*.conf`).   `stream` and other `main` level directives can be included there; see [issue 257](https://github.com/openresty/docker-openresty/issues/257) for an example.

You can override that `default.conf` directly or volume bind-mount the `/etc/nginx/conf.d` directory to your own set of configurations:

```
docker run -v /my/custom/conf.d:/etc/nginx/conf.d openresty/openresty:alpine
```

If you are running on an `selinux` host (e.g. CentOS), you may need to add `:Z` to your [volume bind-mount argument](https://docs.docker.com/storage/bind-mounts/#configure-the-selinux-label):
```
docker run -v /my/custom/conf.d:/etc/nginx/conf.d:Z openresty/openresty:alpine
```

When using the `windows` image you can change the main configuration directly:
```
docker run -v C:/my/custom/nginx.conf:C:/openresty/conf/nginx.conf openresty/openresty:windows
```


OPM
===

Starting at version 1.11.2.2, OpenResty for Linux includes a [package manager called `opm`](https://github.com/openresty/opm#readme), which can be found at `/usr/local/openresty/bin/opm`.

`opm` is built in all the images except `alpine` and `bullseye` and `bookworm`.

To use `opm` in the `alpine` image, you must also install the `curl` and `perl` packages; they are not included by default because they double the image size.  You may install them like so: `apk add --no-cache curl perl`.

To use `opm` within the `bullseye` image, you can either use the `bullseye-fat` image or install the `openresty-opm` package in a custom build (which you would need to do to install your own `opm` packages anyway), as shown in [this buster example](https://github.com/openresty/docker-openresty/blob/master/archive/buster/Dockerfile.opm_example).


LuaRocks
========

[LuaRocks](https://luarocks.org/) is included in the `alpine-fat`, `centos`, and `bionic` variants.  It is excluded from `alpine` because it generally requires a build system and we want to keep that variant lean.

It is available at `/usr/local/openresty/luajit/bin/luarocks`.  Packages can be added in your dependent Dockerfiles like so:

```
RUN /usr/local/openresty/luajit/bin/luarocks install <rock>
```


Tips & Pitfalls
===============

 * The `envsubst` utility is included in all images except `alpine` and `windows`; this utility is also included
 in the Nginx docker image and is used to template environment variables into configuration files.

 * By default, OpenResty is built with SSE4.2 optimizations if the build machine supports it.  If run on machine without SSE4.2, there will be [invalid opcode issues](https://github.com/openresty/docker-openresty/issues/39). **Thus all the Docker Hub images require SSE4.2.**  You can [build a custom image from source](#building-from-source) explicitly without SSE4.2 support, using build arguments like so:
```
docker build -f bionic/Dockerfile --build-arg "RESTY_LUAJIT_OPTIONS=--with-luajit-xcflags='-DLUAJIT_NUMMODE=2 -DLUAJIT_ENABLE_LUA52COMPAT -mno-sse4.2'" .
```

* OpenResty's OpenSSL library version must be compatible with your `opm` and LuaRocks packages' version.  At minimum, the numeric portion should be the same (e.g. `1.1.1`).  The image label `resty_openssl_version` indicates this value. see [Labels](#image-labels).

* The `1.13.6.2-alpine` is built from `OpenSSL 1.0.2r` because of build issues on Alpine. `1.15.8.1-alpine` and later are built from `OpenSSL 1.1.1` series.

* Windows images must be built from the same version as the host system it runs on.  See [Windows container version compatibility](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/version-compatibility).  Our images are currently built from the "Windows Server 2016" series.

* The `SIGQUIT` signal will be sent to nginx to stop this container, to give it an opportunity to stop gracefully (i.e, finish processing active connections).  The Docker default is `SIGTERM`, which immediately terminates active connections.

* Alpine 3.9 added OpenSSL 1.1.1 and we build images against this.  OpenSSL 1.1.1 enabled TLS 1.3 by default, which can create unexpected behavior with ssl_session_(store|fetch)_by_lua*. See this patch, which will ship in OpenResty 1.17.x.1, for more information: https://github.com/openresty/lua-nginx-module/commit/d3dbc0c8102a9978d649c99e3261d93aac547378

Image Labels
============

The image builds are labeled with various information, such as the versions of OpenResty and its dependent libraries.  Here's an example of printing the labels using [`jq`](https://stedolan.github.io/jq/):

```
$ docker pull openresty/openresty:1.17.8.1-0-bionic
$ docker inspect openresty/openresty:1.17.8.1-0-bionic | jq '.[].Config.Labels'
{
  "maintainer": "Evan Wies <evan@*********.net>",
  "resty_add_package_builddeps": "",
  "resty_add_package_rundeps": "",
  "resty_config_deps": "--with-pcre     --with-cc-opt='-DNGX_LUA_ABORT_AT_PANIC -I/usr/local/openresty/pcre/include -I/usr/local/openresty/openssl/include'     --with-ld-opt='-L/usr/local/openresty/pcre/lib -L/usr/local/openresty/openssl/lib -Wl,-rpath,/usr/local/openresty/pcre/lib:/usr/local/openresty/openssl/lib'     ",
  "resty_config_options": "    --with-compat     --with-file-aio     --with-http_addition_module     --with-http_auth_request_module     --with-http_dav_module     --with-http_flv_module     --with-http_geoip_module=dynamic     --with-http_gunzip_module     --with-http_gzip_static_module     --with-http_image_filter_module=dynamic     --with-http_mp4_module     --with-http_random_index_module     --with-http_realip_module     --with-http_secure_link_module     --with-http_slice_module     --with-http_ssl_module     --with-http_stub_status_module     --with-http_sub_module     --with-http_v2_module     --with-http_v3_module     --with-http_xslt_module=dynamic     --with-ipv6     --with-mail     --with-mail_ssl_module     --with-md5-asm     --with-pcre-jit     --with-sha1-asm     --with-stream     --with-stream_ssl_module     --with-threads     ",
  "resty_config_options_more": "",
  "resty_eval_post_make": "",
  "resty_eval_pre_configure": "",
  "resty_eval_post_download_pre_configure": "",
  "resty_image_base": "ubuntu",
  "resty_image_tag": "bionic",
  "resty_luarocks_version": "3.3.1",
  "resty_openssl_patch_version": "1.1.0d",
  "resty_openssl_url_base": "https://www.openssl.org/source/old/1.1.0",
  "resty_openssl_version": "1.1.0l",
  "resty_pcre_version": "8.45",
  "resty_version": "1.17.8.1"
}
```

| Label Name                               | Description                                                                                                           |
|:-----------------------------------------|:----------------------------------------------------------------------------------------------------------------------|
| `maintainer`                             | Maintainer of the image                                                                                               |
| `resty_add_package_builddeps`            | buildarg `RESTY_ADD_PACKAGE_BUILDDEPS`                                                                                |
| `resty_add_package_rundeps`              | buildarg `RESTY_ADD_PACKAGE_RUNDEPS`                                                                                  |
| `resty_apk_alpine_version`               | buildarg `RESTY_APK_ALPINE_VERSION`                                                                                   |
| `resty_apk_key_url`                      | buildarg `RESTY_APK_KEY_URL`                                                                                          |
| `resty_apk_repo_url`                     | buildarg `RESTY_APK_REPO_URL`                                                                                         |
| `resty_apk_version`                      | buildarg `RESTY_APK_VERSION`                                                                                          |
| `resty_apt_pgp`                          | buildarg `RESTY_APT_PGP`                                                                                              |
| `resty_apt_repo`                         | buildarg `RESTY_APT_REPO`                                                                                             |
| `resty_apt_arch`                         | buildarg `RESTY_APT_ARCH`                                                                                             |
| `resty_config_deps`                      | buildarg `_RESTY_CONFIG_DEPS` (internal)                                                                              |
| `resty_config_options_more`              | buildarg `RESTY_CONFIG_OPTIONS_MORE`                                                                                  |
| `resty_config_options`                   | buildarg `RESTY_CONFIG_OPTIONS`                                                                                       |
| `resty_deb_flavor`                       | buildarg `RESTY_DEB_FLAVOR`                                                                                           |
| `resty_deb_version`                      | buildarg `RESTY_DEB_VERSION` ([available versions](https://openresty.org/package/debian/pool/openresty/o/openresty/)) |
| `resty_eval_pre_make`                    | buildarg `RESTY_EVAL_PRE_MAKE`                                                                                        |
| `resty_eval_post_make`                   | buildarg `RESTY_EVAL_POST_MAKE`                                                                                       |
| `resty_eval_pre_configure`               | buildarg `RESTY_EVAL_PRE_CONFIGURE`                                                                                   |
| `resty_eval_post_download_pre_configure` | buildarg `RESTY_EVAL_POST_DOWNLOAD_PRE_CONFIGURE`                                                                     |
| `resty_fat_deb_flavor`                   | buildarg `RESTY_FAT_DEB_FLAVOR`                                                                                       |
| `resty_fat_deb_version`                  | buildarg `RESTY_FAT_DEB_VERSION`                                                                                      |
| `resty_fat_image_base`                   | Name of the base image to build fat images from, buildarg  `RESTY_FAT_IMAGE_BASE`                                     |
| `resty_fat_image_tag`                    | Tag of the base image to build fat images from, buildarg `RESTY_FAT_IMAGE_TAG`                                        |
| `resty_image_base`                       | Name of the base image to build from, buildarg  `RESTY_IMAGE_BASE`                                                    |
| `resty_image_tag`                        | Tag of the base image to build from, buildarg `RESTY_IMAGE_TAG`                                                       |
| `resty_install_base`                     | buildarg `RESTY_INSTALL_BASE`                                                                                         |
| `resty_install_tag`                      | buildarg `RESTY_INSTALL_TAG`                                                                                          |
| `resty_luajit_options`                   | buildarg `RESTY_LUAJIT_OPTIONS`                                                                                       |
| `resty_luarocks_version`                 | buildarg `RESTY_LUAROCKS_VERSION`                                                                                     |
| `resty_openssl_patch_version`            | buildarg `RESTY_OPENSSL_PATCH_VERSION`                                                                                |
| `resty_openssl_url_base`                 | buildarg `RESTY_OPENSSL_URL_BASE`                                                                                     |
| `resty_openssl_version`                  | buildarg `RESTY_OPENSSL_VERSION`                                                                                      |
| `resty_openssl_build_options`            | buildarg `RESTY_OPENSSL_BUILD_OPTIONS`                                                                                |
| `resty_pcre_build_options`               | buildarg `RESTY_PCRE_BUILD_OPTIONS`                                                                                   |
| `resty_pcre_options`                     | buildarg `RESTY_PCRE_OPTIONS`                                                                                         |
| `resty_pcre_sha256`                      | buildarg `RESTY_PCRE_SHA256`                                                                                          |
| `resty_pcre_version`                     | buildarg `RESTY_PCRE_VERSION`                                                                                         |
| `resty_rpm_arch`                         | buildarg `RESTY_RPM_ARCH`                                                                                             |
| `resty_rpm_dist`                         | buildarg `RESTY_RPM_DIST`                                                                                             |
| `resty_rpm_flavor`                       | buildarg `RESTY_RPM_FLAVOR`                                                                                           |
| `resty_rpm_version`                      | buildarg `RESTY_RPM_VERSION`                                                                                          |
| `resty_strip_binaries`                   | buildarg `RESTY_STRIP_BINARIES`                                                                                       |
| `resty_version`                          | buildarg `RESTY_VERSION`                                                                                              |
| `resty_yum_repo`                         | buildarg `RESTY_YUM_REPO`                                                                                             |


Docker CMD
==========

The `-g "daemon off;"` directive is used in the Dockerfile CMD to keep the Nginx daemon running after container creation. If this directive is added to the nginx.conf, then the `docker run` should explicitly invoke `openresty` (or `nginx` for `windows` images):
```
docker run [options] openresty/openresty:bionic openresty
```

Invoke another CMD, for example the `resty` utility, like so:
```
docker run [options] openresty/openresty:bionic resty [script.lua]
```

*NOTE* The `alpine` images do not include the packages `perl` and `ncurses`, which is needed by the `resty` utility.


Building (from source)
======================

This Docker image can be built and customized by cloning the repo and running `docker build` with the desired Dockerfile:

```
git clone https://github.com/openresty/docker-openresty.git
cd docker-openresty
docker build -t myopenresty -f bionic/Dockerfile .
docker run myopenresty
```

Dockerfiles are provided for the following base systems, selecting the Dockerfile path with `-f`:

 * [Alpine](https://github.com/openresty/docker-openresty/blob/master/alpine/Dockerfile) (`alpine/Dockerfile`)
 * [Alpine Fat](https://github.com/openresty/docker-openresty/blob/master/alpine/Dockerfile.fat) (`alpine/Dockerfile.fat`)
 * [Ubuntu Bionic](https://github.com/openresty/docker-openresty/blob/master/bionic/Dockerfile) (`bionic/Dockerfile`)
 * [Ubuntu Focal](https://github.com/openresty/docker-openresty/blob/master/focal/Dockerfile) (`focal/Dockerfile`)
 * [Ubuntu Jammy](https://github.com/openresty/docker-openresty/blob/master/jammy/Dockerfile) (`jammy/Dockerfile`)
 * [Ubuntu Noble](https://github.com/openresty/docker-openresty/blob/master/noble/Dockerfile) (`noble/Dockerfile`)

We used to support more build flavors but have trimmed that down.  Older Dockerfiles are archived in the [`archive`](https://github.com/openresty/docker-openresty/tree/master/archive) folder.


The following are the available build-time options. They can be set using the `--build-arg` CLI argument, like so:

```
docker build --build-arg RESTY_J=4 -f jammy/Dockerfile .
```

| Key                                     | Default | Description |
|:-----------------------------------------| :-----: |:----------- |
| RESTY_IMAGE_BASE                        | "ubuntu" / "alpine" | The Debian or Alpine Docker image base to build `FROM`. |
| RESTY_IMAGE_TAG                         | "noble" / "3.21.3" | The Debian or Alpine Docker image tag to build `FROM`. |
| RESTY_VERSION                           | 1.27.1.2 | The version of OpenResty to use. |
| RESTY_LUAROCKS_VERSION                  | 3.12.0 | The version of LuaRocks to use. |
| RESTY_OPENSSL_VERSION                   | 3.4.1 | The version of OpenSSL to use. |
| RESTY_OPENSSL_PATCH_VERSION             | 3.4.1 | The version of OpenSSL to use when patching. |
| RESTY_OPENSSL_URL_BASE                  | "https://github.com/openssl/openssl/releases/download/openssl-${RESTY_OPENSSL_VERSION}" | The base of the URL to download OpenSSL from. |
| RESTY_OPENSSL_BUILD_OPTIONS             | "enable-camellia enable-seed enable-rfc3779 enable-cms enable-md2 enable-rc5 enable-weak-ssl-ciphers enable-ssl3 enable-ssl3-method enable-md2 enable-ktls enable-fips" | Options to tweak Resty's OpenSSL build. |
| RESTY_PCRE_VERSION                      | 10.44 | The version of PCRE2 to use. |
| RESTY_PCRE_SHA256                       | `86b9cb0aa3bcb7994faa88018292bc704cdbb708e785f7c74352ff6ea7d3175b` | The SHA-256 checksum of the PCRE2 package to check. |
| RESTY_PCRE_BUILD_OPTIONS                | "--enable-jit --enable-pcre2grep-jit --disable-bsr-anycrlf --disable-coverage --disable-ebcdic --disable-fuzz-support \
    --disable-jit-sealloc --disable-never-backslash-C --enable-newline-is-lf --enable-pcre2-8 --enable-pcre2-16 --enable-pcre2-32 \
    --enable-pcre2grep-callout --enable-pcre2grep-callout-fork --disable-pcre2grep-libbz2 --disable-pcre2grep-libz --disable-pcre2test-libedit \
    --enable-percent-zt --disable-rebuild-chartables --enable-shared --disable-static --disable-silent-rules --enable-unicode --disable-valgrind" | Options to tweak Resty's PCRE build.  | 
| RESTY_PCRE_OPTIONS                      | "--with-pcre-jit" | Options to tweak Resty's build args regarding PCRE. |
| RESTY_J                                 | 1 | Sets the parallelism level (-jN) for the builds. |
| RESTY_CONFIG_OPTIONS                    | "--with-compat --without-http_rds_json_module --without-http_rds_csv_module --without-lua_rds_parser --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_geoip_module=dynamic --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module=dynamic --with-ipv6 --with-mail --with-mail_ssl_module --with-md5-asm --with-sha1-asm --with-stream --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads" | Options to pass to OpenResty's `./configure` script. |
| RESTY_LUAJIT_OPTIONS                    | "--with-luajit-xcflags='-DLUAJIT_NUMMODE=2 -DLUAJIT_ENABLE_LUA52COMPAT'" | Options to tweak LuaJIT. |
| RESTY_CONFIG_OPTIONS_MORE               | "" | More options to pass to OpenResty's `./configure` script. |
| RESTY_ADD_PACKAGE_BUILDDEPS             | "" | Additional packages to install with package manager required by build only (removed after installation) |
| RESTY_ADD_PACKAGE_RUNDEPS               | "" | Additional packages to install with package manager required at runtime (not removed after installation) |
| RESTY_EVAL_PRE_CONFIGURE                | "" | Command(s) to run prior to executing OpenResty's `./configure` script. (this can be used to clone a github repo of an extension you want to add to OpenResty, for example.  In that case, dont forget to add the appropriate argument to the RESTY_CONFIG_OPTIONS_MORE argument as described above). |
| RESTY_EVAL_POST_DOWNLOAD_PRE_CONFIGURE  | "" | Command(s) to run after downloading and extracting OpenResty's source tarball, but prior to executing OpenResty's `./configure` script. Working directory will be the extracted OpenResty source directory. |
| RESTY_EVAL_PRE_MAKE                     | "" | Command(s) to run before running `make install`.  |
| RESTY_EVAL_POST_MAKE                    | "" | Command(s) to run after running `make install`.  |
| RESTY_STRIP_BINARIES                    | "" | Set to non-zero to strip binaries in Alpine images. |
These built-from-source flavors include the following modules by default, but one can easily increase or decrease that with the custom build options above:

 * http_addition_module
 * http_auth_request_module
 * http_dav_module
 * http_flv_module
 * http_geoip_module=dynamic
 * http_gunzip_module
 * http_gzip_static_module
 * http_image_filter_module=dynamic
 * http_mp4_module
 * http_random_index_module
 * http_realip_module
 * http_secure_link_module
 * http_slice_module
 * http_ssl_module
 * http_stub_status_module
 * http_sub_module
 * http_v2_module
 * http_v3_module
 * http_xslt_module=dynamic
 * ipv6
 * mail
 * mail_ssl_module
 * md5-asm
 * pcre-jit
 * sha1-asm
 * stream
 * stream_ssl_module
 * stream_ssl_preread_module
 * threads

[Back to TOC](#table-of-contents)


Building (RPM based)
====================

OpenResty now now has [RPMs available](https://openresty.org/en/rpm-packages.html).  The `centos` and `fedora` images use these RPMs rather than building from source.

This Docker image can be built and customized by cloning the repo and running `docker build` with the desired Dockerfile:

 * [CentOS 7 RPM](https://github.com/openresty/docker-openresty/blob/master/centos7/Dockerfile) (`centos/Dockerfile`)
 * [CentOS 8 RPM](https://github.com/openresty/docker-openresty/blob/master/centos/Dockerfile) (`centos/Dockerfile`)
 * [Fedora 35 RPM](https://github.com/openresty/docker-openresty/blob/master/fedora/Dockerfile) (`centos/Dockerfile`)

The following are the available build-time options. They can be set using the `--build-arg` CLI argument, like so:

```
docker build --build-arg RESTY_RPM_FLAVOR="-debug" centos7/Dockerfile .
docker build --build-arg RESTY_RPM_FLAVOR="-debug" centos/Dockerfile .
docker build --build-arg RESTY_RPM_FLAVOR="-debug" -f fedora/Dockerfile .
```

| Key | Default | Description |
|:----- | :-----: |:----------- |
|RESTY_IMAGE_BASE | "centos" | The Centos Docker image base to build `FROM`. |
|RESTY_IMAGE_TAG | "8" | The CentOS Docker image tag to build `FROM`. |
|RESTY_LUAROCKS_VERSION | 3.12.0 | The version of LuaRocks to use. |
|RESTY_YUM_REPO | "https://openresty.org/package/centos/openresty.repo" | URL for the OpenResty YUM Repository. |
|RESTY_RPM_FLAVOR | "" | The `openresty` package flavor to use.  Possibly `"-debug"` or `"-valgrind"`. |
|RESTY_RPM_VERSION | "1.27.1.2-1" | The `openresty` package version to install. |
|RESTY_RPM_DIST | "el8" | The `openresty` package distribution to install. |
|RESTY_RPM_ARCH | "x86_64" | The `openresty` package architecture to install. |

[Back to TOC](#table-of-contents)


Building (DEB based)
====================

OpenResty now now has [Debian Packages (DEBs) available](https://openresty.org/en/deb-packages.html).  The `bullseye` image use these DEBs rather than building from source.

You can derive your own Docker images from this to install your own packages.  See [bookworm/Dockerfile.fat](https://github.com/openresty/docker-openresty/blob/master/bookworm/Dockerfile.fat) and [buster/Dockerfile.luarocks_example](https://github.com/openresty/docker-openresty/blob/master/archive/buster/Dockerfile.luarocks_example).

This Docker image can be built and customized by cloning the repo and running `docker build` with the desired Dockerfile:

 * [Debian Bookworm 12 DEB](https://github.com/openresty/docker-openresty/blob/master/bookworm/Dockerfile) (`bookworm/Dockerfile`)
 * [Debian Bullseye 11 DEB](https://github.com/openresty/docker-openresty/blob/master/bullseye/Dockerfile) (`bullseye/Dockerfile`)

The following are the available build-time options. They can be set using the `--build-arg` CLI argument, like so:

```
docker build --build-arg RESTY_DEB_FLAVOR="-debug" -f bullseye/Dockerfile .
```

| Key | Default | Description |
:----- | :-----: |:----------- |
|RESTY_APT_REPO    | "https://openresty.org/package/debian" | Apt repo to load from. |
|RESTY_APT_PGP     | "https://openresty.org/package/pubkey.gpg" | URL to download APT PGP key from |
|RESTY_APT_ARCH    | `amd64` | Architecture for APT lookups |
|RESTY_IMAGE_BASE  | "debian" | The Debian Docker image base to build `FROM`. |
|RESTY_IMAGE_TAG   | "bullseye-slim" | The Debian Docker image tag to build `FROM`. |
|RESTY_DEB_FLAVOR  | "" | The `openresty` package flavor to use.  Possibly `"-debug"` or `"-valgrind"`. |
|RESTY_DEB_VERSION | "=1.27.1.2-1~bookworm1" | The [Debian package version](https://openresty.org/package/debian/pool/openresty/o/openresty/) to use, with `=` prepended. |
|RESTY_FAT_DEB_FLAVOR  | "" | The `openresty` package flavor to use to install "fat" packages.  Possibly `"-debug"` or `"-valgrind"`. |
|RESTY_FAT_DEB_VERSION | "=1.27.1.2-1~bookworm1" | The [Debian package version](https://openresty.org/package/debian/pool/openresty/o/openresty/) to use to "fat" packages, with `=` prepended. |

 * For `amd64` builds, `RESTY_APT_REPO="https://openresty.org/package/debian"`
 * For `arm64` builds, `RESTY_APT_REPO="https://openresty.org/package/arm64/debian"`

[Back to TOC](#table-of-contents)


Building (APK based)
====================

OpenResty now now has [Alpine Packagesx-5q (APKs) available](https://openresty.org/en/apk-packages.html).  The `alpine-apk` image use these APKs rather than building from source.  You can derive your own Docker images from this to install your own packages.

This Docker image can be built and customized by cloning the repo and running `docker build` with the desired Dockerfile:

 * [Alpine APK](https://github.com/openresty/docker-openresty/blob/master/alpine-apk/Dockerfile) (`alpine-apk/Dockerfile`)

The following are the available build-time options. They can be set using the `--build-arg` CLI argument, like so:

```
docker build --build-arg RESTY_IMAGE_TAG="3.12" -f alpine-apk/Dockerfile .
```

| Key | Default | Description |
|:----- | :-----: |:----------- |
|RESTY_IMAGE_BASE   | "alpine" | The Alpine Docker image base to build `FROM`. |
|RESTY_IMAGE_TAG    | "3.18.12" | The Alpine Docker image tag to build `FROM`. |
|RESTY_APK_ALPINE_VERSION | "3.18" | The Alpine version for RESTY_APK_REPO_URL. |
|RESTY_APK_KEY_URL  | "https://openresty.org/package/admin@openresty.com-5ea678a6.rsa.pub" | The URL of the signing key of the `openresty` package. |
|RESTY_APK_REPO_URL | "https://openresty.org/package/alpine/v${RESTY_APK_ALPINE_VERSION}/main" | The URL of the APK repository for `openresty` package. |
|RESTY_APK_VERSION | "=1.27.1.2-r0" | The suffix to add to the apk install package name: `openresty${RESTY_APK_VERSION`}. |

[Back to TOC](#table-of-contents)


Building (Windows based)
========================

This Docker image can be built and customized by cloning the repo and running `docker build` with the desired Dockerfile:

 * [Windows](https://github.com/openresty/docker-openresty/blob/master/centos-rpm/Dockerfile) (`windows/Dockerfile`)

The following are the available build-time options. They can be set using the `--build-arg` CLI argument, like so:

```
docker build --build-arg RESTY_VERSION="1.27.1.2" -f windows/Dockerfile .
```

| Key | Default | Description |
|:----- | :-----: |:----------- |
|RESTY_INSTALL_BASE | "mcr.microsoft.com/dotnet/framework/runtime" | The Windows Server Docker image name to download and install OpenResty with. |
|RESTY_INSTALL_TAG  | "4.8-windowsservercore-ltsc2019" | The Windows Server Docker image name to download and install OpenResty with. |
|RESTY_IMAGE_BASE   | "mcr.microsoft.com/windows/nanoserver" | The Windows Server Docker image name to build `FROM` for final image. |
|RESTY_IMAGE_TAG    | "1809" | The Windows Server Docker image tag to build `FROM` for final image. |
|RESTY_VERSION      | 1.27.1.2 | The version of OpenResty to use. |

[Back to TOC](#table-of-contents)


Feedback & Bug Reports
======================

You're very welcome to report bugs and give feedback as GitHub Issues:

https://github.com/openresty/docker-openresty/issues

[Back to TOC](#table-of-contents)


Changelog & Authors
===================

 * [CHANGELOG](https://github.com/openresty/docker-openresty/blob/master/CHANGELOG.md)
 * [AUTHORS](https://github.com/openresty/docker-openresty/blob/master/AUTHORS.md)

[Back to TOC](#table-of-contents)


Copyright & License
===================

`docker-openresty` is licensed under the 2-clause BSD license.

Copyright (c) 2017-2024, Evan Wies <evan@neomantra.net>.

This module is licensed under the terms of the BSD license.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[Back to TOC](#table-of-contents)
