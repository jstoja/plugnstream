FROM ubuntu

MAINTAINER Julien Bordellier, me@julienbordellier.com

RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby

