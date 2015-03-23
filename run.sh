#!/bin/bash
BASE_PATH=$(pwd)
CONTAINER="web-server"
sed "/#${CONTAINER}/d" /etc/hosts > /etc/hosts
CID=$(docker run -d -p 80 -p 443 -p 9009 -v ${BASE_PATH}/nginx-log:/var/log/nginx -v ${BASE_PATH}/var-www:/var/www -v ${BASE_PATH}/vhosts:/etc/nginx/vhosts ${CONTAINER})
echo "Container ID -${CID}"
IP=$(docker inspect --format='{{.NetworkSettings.IPAddress}}' ${CID})
echo "IP - ${IP}"
awk=$(echo "\$1 ~ /server_name/{print \"${IP}\t\", substr(\$2,1,length(\$2)-1), \"\t#${CONTAINER}\"}") 
echo ${awk}
awk ${AWK} ${BASE_PATH}/vhosts/*.conf 
