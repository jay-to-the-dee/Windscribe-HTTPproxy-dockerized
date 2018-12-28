FROM debian:9
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install apt-transport-https dirmngr ca-certificates tinyproxy apt-utils debconf-utils dialog # ifupdown2 resolvconf
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

#Windscribe instructions
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
RUN sh -c "echo 'deb https://repo.windscribe.com/debian stretch main' > /etc/apt/sources.list.d/windscribe-repo.list"
RUN apt-get update && apt-get -y install windscribe-cli
