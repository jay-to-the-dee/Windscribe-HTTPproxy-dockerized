FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt-get -y install --no-install-recommends apt-transport-https ca-certificates tinyproxy add-apt-key debconf-utils iptables expect #ifupdown
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections #This is a Docker specific thing because it enforces it's own /etc/resolv.conf

#Windscribe instructions
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
RUN echo 'deb https://repo.windscribe.com/ubuntu zesty main' | tee /etc/apt/sources.list.d/windscribe-repo.list
RUN apt-get update && \
apt-get -y install --no-install-recommends windscribe-cli

#Tinyproxy setup
RUN rm /etc/tinyproxy/*
COPY ./conf/tinyproxy/tinyproxy.conf /etc/tinyproxy

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./docker-entrypoint.sh /
EXPOSE 8888
ENTRYPOINT ["/docker-entrypoint.sh"]
