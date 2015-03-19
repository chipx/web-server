# web-server
# NGINX + PHP5-FPM
docker run -i -p 80 -v /home/chipx/docker/web-server/var-www:/var/www -v /home/chipx/docker/web-server/nginx-log:/var/log/nginx -v /home/chipx/docker/web-server/vhosts:/etc/nginx/vhosts web-server