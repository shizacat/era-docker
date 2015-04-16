== Сервер ESET Remote Administrator ==

=== Сервер ===

docker build -t eraserver --no-cache ./

docker run -d --name eraserver --restart=always -p 2222:2222 -p 1237:1237/udp -p 2223:2223 -v /var/log/eset/RemoteAdministrator/Server:/var/log/eset/RemoteAdministrator/Server eraserver


Если база уже есть нужно найти идентификатор предыдущего инстанса (era_db.tbl_servers - server_uuid) и добавить в настройки сервера:

[ -e ProductInstanceID=66666 ]


Зависит:

- Создать папку для логов - /var/log/eset/RemoteAdministrator/Server


DB_HOST=172.17.42.1 - если база на хост машине


=== Веб консоль ===

docker build -t eraconsole --no-cache ./

docker run -d --name eraconsole --restart=always -p 8080:8080 -v /var/log/eset/RemoteAdministrator/Console:/var/log/eset/RemoteAdministrator/Console eraconsole

Зависит:

- Создать папку для логов - /var/log/eset/RemoteAdministrator/Console


=== Зависимости ===

- Настроить работу базы:
my.cnf
[mysqld]
max_allowed_packet=33M