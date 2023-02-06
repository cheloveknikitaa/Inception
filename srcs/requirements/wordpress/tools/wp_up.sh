#!/bin/bash

# переменные (ВСЕ) тянутся из .env

cmd="$@"
echo "Wordpress building start..."

chown -R www-data:www-data /var/www/html/wordpress/
chmod -R 775 /var/www/
mkdir -p /run/php/
touch /run/php/php"${PHP_VERSION}"-fpm.pid

wp core download --allow-root --path=/var/www/html

echo "Wordpress configuring..."
wp config create --allow-root \
                --dbname="${DB_NAME}" \
                --dbuser="${DB_USER}" \
                --dbhost="${DB_HOST}" \
                --dbpass="${DB_USER_PASSWORD}" \
                --path=/var/www/html/wordpress/
echo "Wordpress core installing..."
wp core install --allow-root \
                --url=${DOMAIN_NAME} \
                --title=inception \
                --admin_user="${WP_ADMIN}" \
                --admin_password="${WP_ADMIN_PASS}" \
                --admin_email="${WP_ADMIN_EMAIL}" \
                --path=/var/www/html/wordpress/

wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
                --role=author --user_pass="${WP_USER_PASS}" \
                --allow-root --path=/var/www/html/wordpress/

if [ "$PART" == 'BONUS']
then
    cat var/www/wp-config.php >> /var/www/html/wordpress/wp-config.php
    wp plugin install redis-cache --activate --allow-root --path="/var/www/html/wordpress"
fi
wp theme install inspiro --activate --allow-root --path="/var/www/html/wordpress" # neve
echo "Wordpress started on :9000"

exec $cmd   #/usr/sbin/php-fpm"${PHP_VERSION}" -F
