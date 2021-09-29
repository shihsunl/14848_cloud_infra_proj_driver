FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Shih-Sung-Lin
ENV PORT 8080
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# setup
RUN mkdir /temp
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y git g++ software-properties-common build-essential language-pack-en unzip curl wget vim libpam0g-dev libssl-dev cmake cron libssl-dev openssl iputils-ping
RUN apt-get install -y apache2 php libapache2-mod-php
RUN apt-get install -y python3
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get install -y python3-pip

RUN pip3 install Flask==2.0.1
RUN pip3 install gunicorn==20.1.0

EXPOSE 80

# get UI code
WORKDIR /temp
RUN git clone https://github.com/shihsunl/14848_cloud_infra_proj_driver.git
RUN cp -r /temp/14848_cloud_infra_proj_driver/www/* /var/www/html/
RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 hello:app
#ENTRYPOINT /etc/init.d/apache2 restart && /bin/bash

