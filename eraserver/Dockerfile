# Version: 0.1
FROM phusion/baseimage:0.9.16

ENV DB_USER_PROOT root
ENV DB_PASS_PROOT root
ENV DB_USER era
ENV DB_PASS era
ENV DB_HOST 172.17.42.1
ENV DB_BASE era_db
ENV HOST_NAMES "192.168.14.147;Ubuntu64-bb;Ubuntu64-bb.BB.LOCAL;b147.cherinfo.ru"
ENV SERVER_ROOT_PASSWORD 11112222

CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive

RUN echo "Europe/Moscow" | sudo tee /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata  && \
    echo "ntpdate ntp1.cherinfo.ru" > /etc/cron.daily/ntpdate && chmod 755 /etc/cron.daily/ntpdate 

RUN apt-get update && \
    apt-get install -y xvfb cifs-utils unixodbc libmyodbc openssl wget && \
    wget http://download.eset.com/download/ra/v6/standalone-installers/server/Server-Linux-x86_64.sh -O /tmp/Server-Linux-x86_64.sh && \
    chmod +x /tmp/Server-Linux-x86_64.sh

RUN echo "[MySql]" > /etc/odbcinst.ini && \
    echo "Driver          = /usr/lib/x86_64-linux-gnu/odbc/libmyodbc.so" >> /etc/odbcinst.ini && \
    echo "Setup           = /usr/lib/x86_64-linux-gnu/odbc/libodbcmyS.so" >> /etc/odbcinst.ini && \
    echo "UsageCount      = 1" >> /etc/odbcinst.ini

RUN echo "[ESET_RA_DB]" > /etc/odbc.ini && \
    echo "Driver	= /usr/lib/x86_64-linux-gnu/odbc/libmyodbc.so" >> /etc/odbc.ini && \
    echo "SERVER	= ${DB_HOST}" >> /etc/odbc.ini && \
    echo "PORT		= 3306" >> /etc/odbc.ini && \
    echo "DATABASE	= ${DB_BASE}" >> /etc/odbc.ini && \
    echo "OPTION	= 3" >> /etc/odbc.ini && \
    echo "USER		= ${DB_USER_PROOT}" >> /etc/odbc.ini && \
    echo "PASSWORD	= ${DB_PASS_PROOT}" >> /etc/odbc.ini 

RUN mkdir /cert
# ADD e_server.pfx /cert/server.pfx
# ADD e_agent.pfx /cert/agent.pfx
# ADD ca.der /cert/ca.der

RUN /tmp/Server-Linux-x86_64.sh \
	--skip-license \
	--db-driver=MySQL \
	--db-type="MySQL Server" \
	--db-hostname=${DB_HOST} \
	--db-port=3306 \
	--db-admin-username=${DB_USER_PROOT} \
	--db-admin-password=${DB_PASS_PROOT} \
	--server-root-password=${SERVER_ROOT_PASSWORD} \
	--db-user-username=${DB_USER} \
	--db-user-password=${DB_PASS} \
	--cert-hostname=${HOST_NAMES} \
	--locale=ru_RU
#	--skip-cert \
#        --server-cert-path="/cert/server.pfx" \
#        --server-cert-password="" \
#        --cert-auth-path="/cert/ca.der"

RUN mkdir /etc/service/eraserver
ADD eraserver.sh /etc/service/eraserver/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
