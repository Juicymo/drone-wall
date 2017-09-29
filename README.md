# Juicymo Drone CI Dashboard

Dashboard for Drone CI we use at Juicymo (compatible with Drone 0.7.0)

[![](https://badge.imagelayers.io/juicymo/drone-wall:latest.svg)](https://imagelayers.io/?images=juicymo/drone-wall:latest 'Get your own badge on imagelayers.io')

## Installation

Compiled Docker image can be pulled from: [Docker Hub](https://hub.docker.com/r/juicymo/drone-wall/).

![](http://dockeri.co/image/juicymo/drone-wall)

## About

This is a Docker image for [Drone Wall](https://github.com/drone/drone-wall) which we use as a dashboard for Drone CI builds at Juicymo. This image is compatible with *Drone 0.7.0*.

This image is based on the [node](https://hub.docker.com/_/node/) image and has been inspired by [nacyot/docker-drone-wall](https://github.com/nacyot/docker-drone-wall).

Because the official [Drone Wall](https://github.com/drone/drone-wall) Docker image does not support deployment to the same VPS where our Drone instance is running out-of-the-box, we have create this Docker image to work in this way.

If you find bugs or issues, let us know via GitHub issues or feel free to fork this Docker image or build a new one based on this one.

*Note: This image currently supports only `THEME`, `API_ROOT`, `ORG_NAME` and `API_TOKEN` Drone Wall ENV variables (we use default values for the rest of them, eg. for colors).*

## How it works?

This Docker image will clone the drone/drone-wall git repo and build the node-js Drone Wall app (using the recommended toolchain npm & grunt) and starts it in a local environment mode on port 3000. This port is exposed out of the Docker container and can be mapped as needed.

## Usage in Docker CLI

You can use this image directly in Docker CLI just typing the following into Terminal:

```
$ docker pull juicymo/drone-wall
$ docker run -p 3000:4000 -e THEME=dark -e API_ROOT=$API_ROOT -e API_TOKEN=$API_TOKEN -e ORG_NAME=$ORG_NAME juicymo/drone-wall
```

Where:

* `$THEME` is either `light` or `dark`
* `$API_ROOT` is URL of your drone instance including protocol and `/api/` suffix (eg. `http://drone.domain.com/api/`)
* `$API_TOKEN` is your access token that will authenticate you with the Drone API (can be found in your Drone account settings)
* `$ORG_NAME` is name of your organisation (eg. `Juicymo` or `Drone`)

## Usage in `docker-compose`

Or your can use this Docker image with `docker-compose` by creating the following `docker-compose.yml` file:

```yaml
version: '2'

services:
  drone-wall:
    image: juicymo/drone-wall
    ports:
      - 3000:4000
    restart: always
    environment:
      - THEME=${DRONE_WALL_THEME}
      - ORG_NAME=${DRONE_WALL_ORG_NAME}
      - API_ROOT=${DRONE_HOST}/api/
      - API_TOKEN=${DRONE_WALL_TOKEN}
```

Environment variables can be specified by creating a `.env` file with the following content:

```
DRONE_HOST=https://drone.example.com
DRONE_WALL_THEME=dark
DRONE_WALL_ORG_NAME=Drone
DRONE_WALL_TOKEN=<PUT_YOUR_DRONE_TOKEN_HERE>
```

The composition can be then run by invoking `docker-compose up` in the same folder where `docker-compose.yml` and `.env` files are.

**Warning:** The `docker-compose.yml` and `.env` files HAVE TO BE in a same folder.

### Optional dependency on `drone-server` service 

We use one `docker-compose.yml` file to run both the Drone CI itself (consisting of `drone-server` and `drone-agent`) and Drone Wall at [Juicymo](http://www.juicymo.cz). If you do the same, you could add a dependency between `drone-wall` and `drone-server` services by adding `depends_on` directive to your `drone-wall` service definition. The updated `docker-compose.yml` will look like:


```yaml
version: '2'

services:
  drone-wall:
    image: juicymo/drone-wall
    ports:
      - 3000:4000
    restart: always
    depends_on:
      - drone-server
    environment:
      - THEME=${DRONE_WALL_THEME}
      - ORG_NAME=${DRONE_WALL_ORG_NAME}
      - API_ROOT=${DRONE_HOST}/api/
      - API_TOKEN=${DRONE_WALL_TOKEN}
```

But we use two DNS records to access both services.

## Notes

We run both *Drone* and *Drone Wall* via docker containers on the same *DigitalOcean* droplet at [Juicymo](http://www.juicymo.cz). 
Drone web UI is accessible at :80 and Drone Wall at :3000. Your setup can be similar.

See source at [GitHub](https://github.com/Juicymo/drone-wall).

See the official Drone Wall repo on GitHub at [drone/drone-wall](https://github.com/drone/drone-wall).