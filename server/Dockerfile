FROM google/nodejs

WORKDIR /app
ADD package.json /app/
RUN npm install
ADD . /app

EXPOSE 9000/udp
CMD []
ENTRYPOINT ["/nodejs/bin/npm", "start"]
