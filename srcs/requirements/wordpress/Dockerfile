FROM        alpine:latest
RUN         apk update && apk upgrade
EXPOSE      9000

RUN         apk add git php-fpm php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

RUN         git clone --depth=1 --branch=master https://github.com/WordPress/WordPress.git /var/www/html/
# ENTRYPOINT  [ "executable" ] ["/etc/init.d/mariadb", "setup"]

# ADD startup /startup
# RUN chmod 700 /startup

# CMD ["/startup"]
