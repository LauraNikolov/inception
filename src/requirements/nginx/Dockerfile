FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt install nginx -y

RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl 
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lnicolof.42.fr/UID=lnicolof"

COPY conf/default.conf /etc/nginx/conf.d/default.conf
RUN chmod +x /etc/nginx/conf.d/default.conf

#si jamais ca prend pas en compte ma config, verifier que y'a pas d'autre fichier de conf qui boot de nouvelles options sur la route php

RUN chmod 775 /var/www/html 
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]
