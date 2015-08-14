FROM ubuntu:14.04
MAINTAINER Sathya Raghunathan
RUN whoami
RUN echo "hello root! below is the current working directory"
RUN sudo apt-get update
RUN sudo apt-get -y install wget
RUN mkdir -p /usr/local/helloworldapp/bin
RUN echo $PATH
RUN export PATH=/usr/local/helloworldapp/bin:$PATH
RUN cd /usr/local/helloworldapp/bin
RUN wget --no-check-certificate  https://raw.githubusercontent.com/testwlmorg/testdock/master/a.out -O helloworld 
RUN chmod 777 helloworld
