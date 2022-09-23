docker stop gitlab > /dev/null 2> /dev/null || :
docker container rm gitlab > /dev/null 2> /dev/null || :

docker run -d \
  --hostname 127.0.0.1 \
  --publish 19080:80 --publish 19022:22 \
  --name gitlab \
  --restart always \
  --volume /home/test/gitLabs/data:/var/opt/gitlab:Z \
  gitlab/gitlab-ce:15.4.0-ce.0