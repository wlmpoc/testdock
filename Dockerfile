FROM node:latest
MAINTAINER Sathya Raghunathan
RUN ./app/index.js /
CMD node index.js
