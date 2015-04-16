# Version: 0.1
FROM phusion/baseimage:0.9.16

CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive

RUN echo "Europe/Moscow" | sudo tee /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata  && \
    echo "ntpdate ntp1.cherinfo.ru" > /etc/cron.daily/ntpdate && chmod 755 /etc/cron.daily/ntpdate 

RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y wget && \
    apt-get install -y oracle-java7-installer tomcat7 && \
#    apt-get install -y openjdk-6-jdk tomcat7 && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk7-installer && \
    wget http://download.eset.com/download/ra/v6/standalone-installers/webconsole/era.war -O /var/lib/tomcat7/webapps/era.war


ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

#RUN apt-get install -y tomcat7 && \
#    wget http://download.eset.com/download/ra/v6/standalone-installers/webconsole/era.war -O /var/lib/tomcat7/webapps/era.war

RUN mkdir /etc/service/tomcat
ADD tomcat.sh /etc/service/tomcat/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
