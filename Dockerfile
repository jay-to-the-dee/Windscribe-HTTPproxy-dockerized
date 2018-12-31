FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install apt-transport-https ca-certificates tinyproxy add-apt-key debconf-utils iptables # ifupdown2 resolvconf
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

#Windscribe instructions
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
RUN echo 'deb https://repo.windscribe.com/ubuntu zesty main' | tee /etc/apt/sources.list.d/windscribe-repo.list
RUN apt-get update && apt-get -y install windscribe-cli expect

#Further Windscribe setup
#Fake null iptables for Windscribe CLI
#RUN touch /sbin/iptables
#RUN chmod a+x /sbin/iptables
#COPY ./conf/windscribe/credentials.txt /etc/windscribe # I tried this as a quicker way to login, doesn't work :(


#Tinyproxy setup
RUN rm /etc/tinyproxy/*
COPY ./conf/tinyproxy/tinyproxy.conf /etc/tinyproxy

#Debug utils
#RUN apt-get -y install nano less iputils-ping

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY ./docker-entrypoint.sh /
EXPOSE 8888
ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]
