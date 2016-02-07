# Juicymo Drone CI Dashboard

Dashboard for Drone CI we use at Juicymo (compatible with Drone 0.4.0)

[![](https://badge.imagelayers.io/juicymo/drone-wall:latest.svg)](https://imagelayers.io/?images=juicymo/drone-wall:latest 'Get your own badge on imagelayers.io')

## Installation

Compiled Docker image can be pulled from: [Docker Hub](https://hub.docker.com/r/juicymo/drone-wall/).

![](http://dockeri.co/image/juicymo/drone-wall)

## About

This is a Docker image for [Drone Wall](https://github.com/drone/drone-wall) which we use as a dashboard for Drone CI builds at Juicymo. This image is compatible with *Drone 0.4.0*.

This image is based on the [node](https://hub.docker.com/_/node/) image and has been inspired by [nacyot/docker-drone-wall](https://github.com/nacyot/docker-drone-wall).

Because the official [Drone Wall](https://github.com/drone/drone-wall) Docker image and repo are not compatible with Drone 0.4.0 yet, we use the [athieriot/drone-wall](https://github.com/athieriot/drone-wall) fork which is already compatible.

If you find bugs or issues, let us know via GitHub issues or feel free to fork this Docker image or build a new one based on this one.

*Note: This image currently supports only `API_SCHEME`, `API_DOMAIN` and `API_TOKEN` Drone Wall ENV variables (we use default values for the rest of them).*

## Usage

Just type the following into Terminal:

```
$ docker pull juicymo/drone-wall
$ docker run -p 3000:3000 -e API_SCHEME=$API_SCHEME -e API_DOMAIN=$API_DOMAIN \
	-e API_TOKEN=$API_TOKEN juicymo/drone-wall
```

Where:

* `$API_SCHEME` is either `http` or `https`
* `$API_DOMAIN` is domain of your drone instance (eg. `drone.domain.com`)
* `$API_TOKEN` is your access token that will authenticate you with the Drone API (can be found in your Drone user settings)

We run both *Drone* and *Drone Wall* via docker containers on the same *DigitalOcean* droplet at [Juicymo](http://www.juicymo.cz). 
Drone web UI is accessible at :80 and Drone Wall at :3000. Your setup can be similar and we do not have issues with CORS from Drone Wall.

See source at [GitHub](https://github.com/Juicymo/drone-wall).

See the official Drone Wall repo on GitHub at [drone/drone-wall](https://github.com/drone/drone-wall).