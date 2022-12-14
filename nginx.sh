#!/bin/bash
docker stop nginx > /dev/null 2> /dev/null || :
docker container rm nginx > /dev/null 2> /dev/null || :

docker run --name nginx -d  \
  --restart=always \
  -p 8088:80 -p 4443:443 \
  -v /home/d_g_j/nginx/etc:/etc/nginx:z \
  -v /home/d_g_j/nginx/log:/var/log/nginx  \
  --volumes-from jenkins \
  --network qnear \
  k:nginx   
