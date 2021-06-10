FROM ruby:3.0.1-alpine3.13
ENV LANG C.UTF-8

RUN apk add --no-cache build-base libxslt-dev libxml2-dev tzdata && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \ 
    wget -O /tmp/glibc-2.33-r0.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-2.33-r0.apk && \
    apk add --no-cache /tmp/glibc-2.33-r0.apk && \
    rm /tmp/glibc-2.33-r0.apk

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock /usr/src/app/

RUN bundle install -j4

COPY . /usr/src/app

EXPOSE 3000
