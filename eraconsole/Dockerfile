# Version: 0.1
FROM tomcat:7.0-jre7

# RUN echo "Europe/Moscow" | sudo tee /etc/timezone && \
#     dpkg-reconfigure --frontend noninteractive tzdata  && \
#     echo "ntpdate ntp1.cherinfo.ru" > /etc/cron.daily/ntpdate && chmod 755 /etc/cron.daily/ntpdate 

# RUN wget http://download.eset.com/download/ra/v6/standalone-installers/webconsole/era.war -O /var/lib/tomcat/webapps/era.war
ADD	era.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]