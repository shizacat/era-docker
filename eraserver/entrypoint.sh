# Настройка и запуск сервера

#!/bin/bash

# ==============
# Variable
# ==============

# Marker for first running
check_first_start="/first_start"

# ==============
# Do
# ==============

# Settings time and zone
echo ${TIMEZONE} | tee /etc/timezone && \
	dpkg-reconfigure --frontend noninteractive tzdata

echo "ntpdate ${NTP_SERVER}" > /etc/cron.daily/ntpdate && chmod 755 /etc/cron.daily/ntpdate

# Not First Start
if [ -f ${check_first_start} ]; then
fi

# First Start
if [ ! -f ${check_first_start} ]; then
	touch ${check_first_start}
fi

# Насройка GUID of server (--product-guid)
[[ ! -z $ProductInstanceID ]] && [[ -f /etc/opt/eset/RemoteAdministrator/Server/config.cfg ]] && \
	sed -i "s/^ProductInstanceID=.*/ProductInstanceID=$ProductInstanceID/g" /etc/opt/eset/RemoteAdministrator/Server/config.cfg


