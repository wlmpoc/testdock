FROM ubuntu:14.04
MAINTAINER Sathya Raghunathan
RUN whoami
RUN echo "hello root! below is the current working directory"
#RUN chmod 777 /helloworldapp/a.out
#RUN /helloworldapp/a.out
RUN sudo apt-get update
RUN sudo apt-get -y install gcc
RUN sudo apt-get -y install wget
RUN mkdir -p /usr/local/helloworldapp/bin
RUN echo $PATH
RUN export PATH=/usr/local/helloworldapp:$PATH
RUN which gcc
RUN wget --no-check-certificate  https://github.com/testwlmorg/testdock.git/master -O /helloworldapp/
RUN cd /usr/local/helloworldapp
RUN gcc helloworld.c -o bin/helloworld
RUN chmod 777 helloworld
RUN helloworld
