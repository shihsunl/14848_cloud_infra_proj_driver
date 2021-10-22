FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Shih-Sung-Lin
ENV PORT 8080
EXPOSE 80 22 8080 443
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# setup
RUN mkdir /temp
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y git g++ software-properties-common build-essential language-pack-en unzip curl wget vim libpam0g-dev libssl-dev cmake cron libssl-dev openssl iputils-ping openssh-server sudo
RUN apt-get install -y apache2 php libapache2-mod-php
RUN apt-get install -y python3
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get install -y python3-pip
RUN pip3 install Flask==2.0.1
RUN pip3 install gunicorn==20.1.0

# get UI code
WORKDIR /temp
RUN git clone https://github.com/shihsunl/14848_cloud_infra_proj_driver.git
RUN cp -r /temp/14848_cloud_infra_proj_driver/www/* /var/www/html/
RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf
#RUN /etc/init.d/apache2 restart
RUN a2enmod proxy
RUN a2enmod ssl
RUN a2enmod proxy_http
RUN a2enmod proxy_balancer
RUN cp -r /temp/14848_cloud_infra_proj_driver/* /temp/
RUN cp -r apache2_config/000-default.conf /etc/apache2/sites-available/000-default.conf

# install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# enable ssh tunnel
RUN echo "if [[ -n \$SSH_CONNECTION ]] ; then\n    /temp/run.sh\nfi" >> /etc/bash.bashrc
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test
RUN echo 'test:test' | chpasswd # sets the password for the user test to test

CMD /etc/init.d/ssh restart && /etc/init.d/apache2 restart && exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 hello:app
