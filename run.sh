#!/bin/bash
BASE_PATH=$(pwd)
CONTAINER="web-server"
if [ ! -e /etc/hosts-backup ]; then
    cp /etc/hosts /etc/hosts-backup
fi
sed -i "/#${CONTAINER}/d" /etc/hosts
CID=$(docker run -d --link redis:redis.local -p 80 -p 443 -p 9009 -v ${BASE_PATH}/nginx-log:/var/log/nginx -v ${BASE_PATH}/var-www:/var/www -v ${BASE_PATH}/vhosts:/etc/nginx/vhosts ${CONTAINER})
echo "Container ID -${CID}"
IP=$(docker inspect --format='{{.NetworkSettings.IPAddress}}' ${CID})
echo "IP - ${IP}"
awk -v ip=${IP} -v container=${CONTAINER} '$1 ~ /server_name/{print ip gensub(/server_name\W+([^;]+);/,"\\1",$0),"#" container}' ${BASE_PATH}/vhosts/*.conf >> /etc/hosts
