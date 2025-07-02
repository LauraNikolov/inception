FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt install -y mariadb-server && apt install mariadb-client -y


RUN mkdir -p /var/run/mysqld \
&& chown -R mysql:mysql /var/run/mysqld \
&& chmod 777 /var/run/mysqld

COPY /tools/init-db.sh /var/local/bin/init-db.sh
COPY /conf/mysqld.cnf /etc/mysql/my.cnf
RUN chmod +x /var/local/bin/init-db.sh
RUN chmod +x /etc/mysql/my.cnf

EXPOSE 3306

ENTRYPOINT  ["/var/local/bin/init-db.sh"]
CMD ["mysqld"]