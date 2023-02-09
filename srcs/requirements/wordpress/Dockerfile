FROM debian:buster

RUN apt-get update && apt-get install -y wget php-fpm php-json php-mysql

RUN /etc/init.d/php7.3-fpm start

RUN sed -i 's/\/run\/php\/php7.3-fpm.sock/9000/g' /etc/php/7.3/fpm/pool.d/www.conf && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && \
    mkdir -p /var/www/html/wordpress

EXPOSE 9000

ADD ./tools/create_wp.sh /
COPY ./conf/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
COPY ./conf/wp-config.php /var/www/

RUN chmod +x create_wp.sh

ENTRYPOINT [ "/create_wp.sh" ]

CMD [ "php-fpm7.3", "--nodaemonize" ]