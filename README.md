# Сервер ESET Remote Administrator

### Сервер

```sh
docker build -t eraserver --no-cache ./

docker run -d \
	--name eraserver \
	--restart=always \
	-p 2222:2222 \
	-p 1237:1237/udp \
	-p 2223:2223 \
	-v /var/log/eset/RemoteAdministrator/Server:/var/log/eset/RemoteAdministrator/Server \
	-v /etc/localtime:/etc/localtime:ro \
	eraserver
```

Если база уже есть нужно найти идентификатор предыдущего инстанса (era_db.tbl_servers - server_uuid) и добавить в настройки сервера:

[ -e ProductInstanceID=66666 ]

При создании образа нужно задать пароль администратора сервера 
```sh
SERVER_ROOT_PASSWORD=11112222
```

##### Зависит:

- Создать папку для логов - /var/log/eset/RemoteAdministrator/Server

```sh
DB_HOST=172.17.42.1 - если база на хост машине
```

Могут понадобиться сертификаты - пока не включены


### Веб консоль

Копируем в папку с докер файлом:
```sh
wget http://download.eset.com/download/ra/v6/standalone-installers/webconsole/era.war

docker build -t eraconsole --no-cache ./

docker run -d \
	--name eraconsole \
	--restart=always \
	-p 127.0.0.1:8080:8080 \
	-v /var/log/eset/RemoteAdministrator/Console:/var/log/eset/RemoteAdministrator/Console \
	-v /etc/localtime:/etc/localtime:ro \
	eraconsole
```

##### Зависит:

- Создать папку для логов - /var/log/eset/RemoteAdministrator/Console
- Прописать адрес сервера после первого запуска:
```sh
export SERVER_ADDRESS=172.17.42.1

[[ ! -z $SERVER_ADDRESS ]] && [[ -f /usr/local/tomcat/webapps/era/WEB-INF/classes/sk/eset/era/g2webconsole/server/modules/config/EraWebServerConfig.properties ]] && \
	sed -i "s/^server_address=.*/server_address=$SERVER_ADDRESS/g" /usr/local/tomcat/webapps/era/WEB-INF/classes/sk/eset/era/g2webconsole/server/modules/config/EraWebServerConfig.properties
```

### Зависимости

- Настроить работу базы:
```sh
my.cnf
[mysqld]
max_allowed_packet=33M

log_bin_trust_function_creators = 1
binlog_format = row
```
