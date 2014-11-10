FROM phusion/baseimage:0.9.15
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

# avoid interactive dialouges from apt:
ENV DEBIAN_FRONTEND noninteractive

# add repos and update:
RUN add-apt-repository ppa:webupd8team/java; apt-get update; apt-get -y dist-upgrade

# install java8:
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections; apt-get -y install oracle-java8-installer

# set java8 default:
RUN apt-get install oracle-java8-set-default

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# clean up
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set java security
RUN sed -e 's%^\(securerandom.source\)=.*%\1=file:/dev/./urandom%' \
        -i $JAVA_HOME/jre/lib/security/java.security