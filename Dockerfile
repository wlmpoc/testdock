FROM node:latest
MAINTAINER Sathya Raghunathan
COPY app/index.js /
CMD node index.js
