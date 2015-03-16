FROM ubuntu:14.10

RUN apt-get update && apt-get install -y nginx
RUN mkdir -p /etc/nginx/vhosts
RUN mkdir -p /var/www 
RUN cd /etc/nginx && sed 's/sites-enabled\/\*/vhosts\/\*/g' nginx.conf > nginx.conf

VOLUME ["/etc/nginx/vhosts", "/var/www", "/var/log/nginx"]

EXPOSE 80 443
