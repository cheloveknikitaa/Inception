#!/bin/bash

# переменные (ВСЕ) тянутся из .env

cmd="$@"
echo "Wordpress building start..."

chown -R www-data:www-data /var/www/html/wordpress/
chmod -R 775 /var/www/
mkdir -p /run/php/
touch /run/php/php"${PHP_VERSION}"-fpm.pid

echo "Wordpress configuring..."
wp config create --allow-root \
                --dbname="${DB_NAME}" \
                --dbuser="${DB_USER}" \
                --dbhost="${DB_HOST}" \
                --dbpass="${DB_USER_PASSWORD}" \
                --path=/var/www/html/wordpress/
sleep 5                                             # НЕ УМЕНЬШАТЬ значение (иначе не будет связи с БД)
echo "Wordpress core installing..."
wp core install --allow-root \
                --url=caugusta.42.fr \
                --title=Pentagon-Almost-Official-Site \
                --admin_user="${WP_ADMIN}" \
                --admin_password="${WP_ADMIN_PASS}" \
                --admin_email="${WP_ADMIN_EMAIL}" \
                --path=/var/www/html/wordpress/

wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
                --role=author --user_pass="${WP_USER_PASS}" \
                --allow-root --path=/var/www/html/wordpress/

wp plugin install redis-cache --activate --allow-root --path="/var/www/html/wordpress"
wp theme install inspiro --activate --allow-root --path="/var/www/html/wordpress" # neve
echo "Wordpress started on :9000"

exec $cmd   #/usr/sbin/php-fpm"${PHP_VERSION}" -F
