# FROM python:3.6.13-slim-buster
FROM centos:7.8.2003

COPY ./redis-5.0.14.tar.gz /

RUN set -x \
    && yum --nogpg install -y gcc make glibc openssl-devel dpkg-devel \
    && mkdir -p /usr/src/redis \
    && tar -xzf /usr/src/redis --strip-components=1 -f redis-5.0.14.tar.gz \
    && rm redis-5.0.14.tar.gz