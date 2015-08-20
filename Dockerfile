FROM centos:latest
MAINTAINER Sathya Raghunathan
RUN sudo yum update
RUN sudo yum install wget
RUN mkdir -p /usr/local/helloworldapp/bin
RUN export PATH=/usr/local/helloworldapp/bin:$PATH
RUN wget --no-check-certificate  https://raw.githubusercontent.com/testwlmorg/testdock/master/a.out -O /usr/local/helloworldapp/bin/helloworld 
RUN chmod 777 /usr/local/helloworldapp/bin/helloworld
