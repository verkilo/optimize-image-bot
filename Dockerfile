FROM ruby:latest
# FROM ubuntu:latest

ARG USERNAME=imagemagick

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

RUN apt-get update -yqq && \
  apt-get install -yqq \
  ca-certificates

RUN apt-get install -yqq locales && locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get install -yqq imagemagick

COPY optimize-image.rb /optimize-image.rb
RUN chmod -R 755 /optimize-image.rb
ENTRYPOINT ["/optimize-image.rb"]