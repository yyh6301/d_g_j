docker stop jenkins > /dev/null 2> /dev/null || :
docker container rm jenkins > /dev/null 2> /dev/null || :


docker run \
  -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home:z \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/user/bin/docker \
  --env="JENKINS_OPTS=--prefix=/jenkins" \
  -v deploy:/var/deploy:z \
  --network qnear \
  y:d_g_j

#   --restart=always \