# FROM python:3.6.13-slim-buster
FROM centos:7.8.2003

COPY ./redis-5.0.14.tar.gz /

RUN set -x \
    && yum --nogpg install -y gcc make glibc openssl-devel dpkg-devel \
    && mkdir -p /usr/src/redis \
    && tar -xzC /usr/src/redis --strip-components=1 -f redis-5.0.14.tar.gz \
    && rm redis-5.0.14.tar.gz \
# disable Redis protected mode [1] as it is unnecessary in context of Docker
# (ports are not automatically exposed when running inside Docker, but rather explicitly by specifying -p / -P)
# [1]: https://github.com/redis/redis/commit/edd4d555df57dc84265fdfb4ef59a4678832f6da
	&& grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h; \
	&& sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h