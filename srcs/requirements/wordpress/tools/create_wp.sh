#!/bin/bash

wp core download --allow-root --path=/var/www/html/wordpress

wp config create --skip-check --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbhost=$MYSQL_HOST --dbpass=$MYSQL_PASSWORD --path=/var/www/html/wordpress

wp core install --allow-root --url=$DOMAIN_NAME --title=inception --admin_user=$WORDPRESS_ADMIN --admin_password=$WORDPRESS_ADMIN_PASS --admin_email=$WORDPRESS_ADMIN_EMAIL --path=/var/www/html/wordpress

wp user create --allow-root $WORDPRESS_USER $WORDPRESS_USER_EMAIL --user_pass=$WORDPRESS_USER_PASS --path=/var/www/html/wordpress

wp plugin install redis-cache --activate --allow-root --path="/var/www/html/wordpress"
wp theme install inspiro --activate --allow-root --path="/var/www/html/wordpress"

cat /var/www/wp-config.php >> /var/www/html/wordpress/wp-config.php

chmod -R 777 /var/www/html/wordpress

echo "Wordpress started on :9000"

exec "$@"
