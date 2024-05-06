FROM debian:buster-slim
MAINTAINER BR Systems

RUN apt-get update \
 && mkdir -p /usr/share/man/man1 \
 && apt-get install -y locales \
 && dpkg-reconfigure -f noninteractive locales \
 && locale-gen C.UTF-8 \
 && /usr/sbin/update-locale LANG=C.UTF-8 \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Users with other locales should set this in their derivative image
ENV LANG n_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update \
 && apt-get install -y software-properties-common \
 && apt-get install -y wget curl unzip \
 && apt-get install -y build-essential libssl-dev libffi-dev python3-dev \
 && apt-get install -y python3-pip

RUN pip3 install --user --upgrade pip \
 && pip3 install https://github.com/jupyter/notebook/releases/download/v6.5.7/notebook-6.5.7-py3-none-any.whl \
 && pip3 install jupyter_contrib_nbextensions \
 && jupyter contrib nbextension install --user \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
