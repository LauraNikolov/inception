FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl 
RUN apt-get install -y php php7.4-fpm php-mysql 
RUN apt-get install -y mariadb-client netcat
RUN apt-get install -y wget

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir /run/php

RUN cd /usr/local/bin && \
    curl -o wp -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp
COPY /tools/wordpress-entrypoint.sh /usr/local/bin/wordpress-entrypoint.sh

RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh
WORKDIR /var/www/html/
EXPOSE 9000

ENTRYPOINT ["wordpress-entrypoint.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]