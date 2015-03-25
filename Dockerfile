FROM ubuntu:14.10

RUN apt-get update && apt-get install -y nginx
RUN mkdir -p /etc/nginx/vhosts
RUN mkdir -p /var/www 
COPY nginx.conf /etc/nginx/nginx.conf

RUN apt-get update && apt-get install -y php5-common php5-curl\
    php5-dev php5-fpm php5-gd php5-geoip php5-imagick php5-json\
    php5-mcrypt php5-memcache php5-memcached php5-mysql\
    php5-readline php5-stomp php5-xdebug php5-redis php5-mongo

RUN cd /tmp && php -r "readfile('https://getcomposer.org/installer');" | php
RUN cd /tmp && mv composer.phar /usr/local/bin/composer

RUN apt-get update && apt-get install -y supervisor
RUN apt-get clean
COPY supervisor.conf /etc/supervisor/conf.d/web.conf
VOLUME ["/etc/nginx/vhosts", "/var/www", "/var/log/nginx", "/etc/php5/mods-available"]

EXPOSE 80 443 9009
CMD ["/usr/bin/supervisord"]
