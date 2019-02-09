FROM node:lts-slim
MAINTAINER Sathya Raghunathan
COPY app/index.js /
CMD node index.js
