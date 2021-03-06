# https://github.com/ctaggart/golang-vscode
# https://hub.docker.com/r/ctaggart/golang-vscode/

# https://golang.org/
# https://hub.docker.com/_/golang/
# https://github.com/docker-library/golang
FROM golang:latest

COPY root /root

ENV DEBIAN_FRONTEND noninteractive

# for development
# ip=`ifconfig bridge100 | grep inet | awk '$1=="inet" {print $2}'`
# docker run --rm -it -v $PWD/root:/root -w /root -e DISPLAY=$ip:0 golang:latest

RUN cd /root \
  && ./install-apt-packages.sh \
  && useradd -m vscode -s /bin/bash \
  && cp install-vscode-extension*.sh /home/vscode/ \
  && chown vscode:vscode /home/vscode/install-vscode-extension*.sh \
  && su vscode -c /home/vscode/install-vscode-extensions.sh

# TODO figure out how to launch it
# CMD su vscode -c code /home/vscode
# CMD ./start-vscode.sh
WORKDIR /root
CMD /bin/bash