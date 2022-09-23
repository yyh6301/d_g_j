FROM golang:alpine as go_img

# FROM jenkins/jenkins:lts-alpine
FROM jenkins/jenkins:alpine

#定义变量
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000

USER root
#设置环境
ENV JENKINS_OPTS "--prefix=/jenkins"

ENV DOCKER_HOME /usr/local/docker

ENV GOROOT /usr/local/go
ENV GOPROXY "https://goproxy.cn,direct"
ENV GOSUMDB "sum.golang.google.cn"

ENV DEPLOY /var/deploy

ENV GOPATH $DEPLOY/kUser/goUser

ENV PATH $GOPATH/bin:$DOCKER_HOME:$GOROOT/bin:$PATH

ENV alpineMirror="https://mirrors.aliyun.com"
# ENV alpineMirror="https://mirrors.cloud.tencent.com"
# ENV alpineMirror="https://mirrors.tuna.tsinghua.edu.cn"
ENV majorVer=v3.15

RUN rm -f /etc/apk/repositories \
&& echo "${alpineMirror}"/alpine/"${majorVer}"/main/ >> /etc/apk/repositories \
&& echo "${alpineMirror}"/alpine/"${majorVer}"/community/  >> /etc/apk/repositories \
&& echo "${alpineMirror}"/alpine/"${majorVer}"/community/ >> /etc/apk/repositories

RUN apk upgrade musl

RUN apk --update add --no-cache tzdata rsync grep sudo xz zsh vim \
  wget git openssh-client curl unzip bash coreutils \
  tcl linux-headers build-base alpine-sdk openjdk11 \
  cmake make musl-dev gcc gettext-dev libintl openssl


RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN cp /usr/share/zoneinfo/Asia/Chongqing /etc/localtime
RUN echo "Asia/Chongqing" > /etc/timezone

ARG DOCKER_VERSION="20.10.13"
#ENV DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz"
# *****************************
# install docker client
ADD docker-$DOCKER_VERSION.tgz /usr/local/

RUN echo '#!/bin/bash' >> /bin/d \
&& echo 'sudo docker $@' >> /bin/d \
&& chmod +x /bin/d

# *****************************
# install goLang
COPY --from=go_img /usr/local/go/ $GOROOT

# DEPLOY directory is a volume
VOLUME $DEPLOY

# ~/kUser/dockerImg/jenkins/