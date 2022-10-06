docker stop gitlab > /dev/null 2> /dev/null || :
docker container rm gitlab > /dev/null 2> /dev/null || :

sudo docker run --detach \
  --hostname 127.0.0.1 \
  --publish 19080:80 --publish 19022:22 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  --network qnear \
  --shm-size 256m \
  gitlab/gitlab-ee:latest


# docker run -d \
#   --hostname 127.0.0.1 \
#   --publish 19080:80 --publish 19022:22 \
#   --name gitlab \
#   --restart always \
#   --volume /home/test/gitLabs/data:/var/opt/gitlab:Z \
#   gitlab/gitlab-ce:15.4.0-ce.0

#   --volume /home/test/gitLabs/config:/ect/gitlab:z  \
#   --volume /home/test/gitLabs/log:/var/log/gitlab:Z \


#容器内通信，直接端口通信，本机才要是19080/19022
#git clone ssh://git@gitlab/gitlab-instance-31219f4b/test.git
#git clone http://gitlab:80/gitlab-instance-31219f4b/test.git