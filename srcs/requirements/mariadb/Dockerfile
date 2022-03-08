FROM        alpine:latest
RUN         apk update && apk upgrade
EXPOSE      3306

RUN         apk add mariadb mariadb-client

ENTRYPOINT  [ "executable" ] ["/etc/init.d/mariadb", "setup"]

ADD         ./tools/startup /startup
RUN         chmod 700 /startup

CMD         ["/startup"]