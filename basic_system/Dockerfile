FROM ubuntu:18.04
RUN ln -f -s /bin/bash /bin/sh \
    && apt-get update \
    && apt-get install -y vim \
    && apt-get install -y wget \
    && rm /var/lib/apt/* -rf
ONBUILD RUN apt-get update
