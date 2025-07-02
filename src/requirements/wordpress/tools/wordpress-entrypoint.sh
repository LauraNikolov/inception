#!/bin/bash

set -e

# Attente de la BDD
until nc -z -v -w30 mariadb 3306
do
  echo "Waiting for MariaDB to be ready..."
  sleep 5
done

cd /var/www/html

if [ -f ./wp-config.php ]; then
  echo "✅ WordPress déjà installé"
else
  echo "⬇️ Téléchargement de WordPress"
  wget https://wordpress.org/latest.tar.gz
  tar -xzf latest.tar.gz
  mv wordpress/* .
  rm -rf latest.tar.gz wordpress

  echo "🔧 Configuration des permissions"
  chmod -R 755 /var/www/html
  chown -R www-data:www-data /var/www/html

  echo "🛠️ Configuration de wp-config.php"
  sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config-sample.php
  sed -i "s/username_here/${MYSQL_USER}/" wp-config-sample.php
  sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config-sample.php
  sed -i "s/localhost/${MYSQL_HOSTNAME}/" wp-config-sample.php
  cp wp-config-sample.php wp-config.php

  echo "⚙️ Installation de WordPress via WP-CLI"
  wp core install --allow-root \
	--url="${DOMAIN_NAME}" \
	--title="${WORDPRESS_TITLE}" \
	--admin_user="${WORDPRESS_ADMIN_USER}" \
	--admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
	--admin_email="${WORDPRESS_ADMIN_EMAIL}" \
 	--skip-email

  wp user create --allow-root "${WORDPRESS_USER}" "${WORDPRESS_EMAIL}" --role=author --user_pass="${WORDPRESS_PASSWORD}"


fi

exec "$@"
