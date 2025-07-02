#!/bin/bash

# Initialiser la base de données MariaDB
mysqld --initialize --user=mysql --datadir=/var/lib/mysql

# Démarrer MariaDB en arrière-plan
mysqld_safe --datadir=/var/lib/mysql &

# Attendre que MariaDB démarre
until mysqladmin ping --silent; do
  echo "En attente de MariaDB..."
  sleep 2
done

# Vérifier si la base de données existe
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
  echo "La base de données existe déjà."
else
  # Créer la base de données et l'utilisateur
  echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot
  mysql -u root <<EOF
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOF
  echo "✅ Base de données et utilisateur créés."
fi

mysqladmin shutdown
exec "$@"