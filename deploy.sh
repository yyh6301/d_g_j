docker stop jenkins > /dev/null 2> /dev/null || :
docker container rm jenkins > /dev/null 2> /dev/null || :


docker run \
  -d \
  --restart = always \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home:z \
  --env="JENKINS_OPTS=--prefix=/jenkins" \
  -v deploy:/var/deploy:z \
  --network bridge \
  y:d_g_j
