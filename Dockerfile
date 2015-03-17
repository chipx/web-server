FROM ubuntu:14.10

RUN apt-get update && apt-get install -y nginx
RUN mkdir -p /etc/nginx/vhosts
RUN mkdir -p /var/www 
COPY nginx.conf /etc/nginx/nginx.conf

RUN apt-get update && apt-get install -y php5-common php5-curl\
    php5-dev php5-fpm php5-gd php5-geoip php5-imagick php5-json\
    php5-mcrypt php5-memcache php5-memcached php5-mysql\
    php5-readline php5-stomp php5-xdebug

RUN apt-get update && apt-get install -y supervisor

VOLUME ["/etc/nginx/vhosts", "/var/www", "/var/log/nginx"]

EXPOSE 80 443 9002
