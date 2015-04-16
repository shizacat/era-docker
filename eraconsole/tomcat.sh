#!/bin/sh

[[ -f /var/lib/tomcat7/webapps/era/WEB-INF/classes/sk/eset/era/g2webconsole/server/modules/config/EraWebServerConfig.properties ]] && sed -i 's/^server_address=.*/server_address=172.17.42.1/g' /var/lib/tomcat7/webapps/era/WEB-INF/classes/sk/eset/era/g2webconsole/server/modules/config/EraWebServerConfig.properties

service tomcat7 start

