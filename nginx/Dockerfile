FROM nginx:alpine

ENV ALPINE_MIRROR="https://mirrors.cloud.tencent.com"
#ENV ALPINE_MIRROR="https://mirrors.tuna.tsinghua.edu.cn"

RUN rm -f /etc/apk/repositories && \
  echo $ALPINE_MIRROR/alpine/latest-stable/main/ >> /etc/apk/repositories && \
  echo $ALPINE_MIRROR/alpine/latest-stable/community/ >> /etc/apk/repositories

RUN apk update && apk upgrade

RUN apk --update add --no-cache tzdata sudo certbot certbot-nginx && \
  echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers && \
  cp /usr/share/zoneinfo/Asia/Chongqing /etc/localtime && \
  echo "Asia/Chongqing" > /etc/timezone

RUN apk update && apk upgrade