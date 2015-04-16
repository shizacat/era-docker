#!/bin/sh

[[ ! -z $ProductInstanceID ]] && [[ -f /etc/opt/eset/RemoteAdministrator/Server/config.cfg ]] && \
	sed -i "s/^ProductInstanceID=.*/ProductInstanceID=$ProductInstanceID/g" /etc/opt/eset/RemoteAdministrator/Server/config.cfg

service eraserver start
