FROM debian:buster

COPY sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y net-tools tig emacs

WORKDIR /var/opt

ENTRYPOINT ["emacs"]
