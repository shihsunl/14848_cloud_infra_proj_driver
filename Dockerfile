FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Shih-Sung-Lin

RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# setup
RUN mkdir /temp
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y git g++ software-properties-common build-essential language-pack-en unzip curl wget vim libpam0g-dev libssl-dev cmake cron libssl-dev openssl iputils-ping
RUN apt-get install -y apache2 php libapache2-mod-php
EXPOSE 80

WORKDIR /temp
ENTRYPOINT /etc/init.d/apache2 restart && /bin/bash

