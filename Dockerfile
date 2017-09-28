# We use this Docker image as CI status wall in our office at Juicymo (www.juicymo.cz)

# see https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/ for Dockerfile best practices

# build me with:
# docker build -t "juicymo/drone-wall:1.1.0" .

# run me with:
# docker run -p 3000:3000 -e THEME=dark -e API_ROOT=$API_DOMAIN -e API_TOKEN=$API_TOKEN -e ORG_NAME=$ORG_NAME juicymo/drone-wall

FROM node
MAINTAINER Tomas Jukin <tomas.jukin@juicymo.cz>

RUN \
  apt-get update &&\
  apt-get install -y git curl wget

RUN git clone https://github.com/drone/drone-wall.git /app
WORKDIR /app
RUN \
  npm install &&\
  npm install -g grunt-cli
  #grunt --env=prod -theme=$THEME -apiroot=$API_ROOT -token=$API_TOKEN -orgname=$ORG_NAME

EXPOSE 3000
CMD npm start -- -env=prod -theme=$THEME -apiroot=$API_ROOT -token=$API_TOKEN -orgname=$ORG_NAME