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

ENVERONMENT:

* ProductInstanceID - идентификатор инстанса
* SERVER_ROOT_PASSWORD - пароль на доступ к серверу (под логином Administrator)

* TIMEZONE - временная зона (default: Europe/Moscow)
* NTP_SERVER - сервер врмени

* DB_USER_PROOT - имя администратора базы (для установки)
* DB_PASS_PROOT - пароль администратора базы (для установки)
* DB_USER - имя пользователя базы для era server
* DB_PASS - пароль пользователя базы для era server
* DB_HOST - Адрес базы данных (default: 172.17.0.1)
* DB_BASE - Имя базы данных (default: era_db)



##### Зависит:

- Создать папку для логов - /var/log/eset/RemoteAdministrator/Server

```sh
DB_HOST=172.17.0.1 - если база на хост машине, Для Docker версии меньше 1.9 - 172.17.42.1
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
