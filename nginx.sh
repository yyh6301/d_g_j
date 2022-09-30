#!/bin/bash
docker stop nginx > /dev/null 2> /dev/null || :
docker container rm nginx > /dev/null 2> /dev/null || :

docker run --name nginx -d --restart=always \
  -p 8088:80 -p 4443:443 \
  -v /home/test/nginx/data:/data:z \
  -v /home/test/nginx/etc:/etc/nginx:z \
  -v /home/test/nginx/log:/var/log/nginx:z \
  --network qnear \
  k:nginx 