# minimalka
lightweight Docker image for JDK11 micro-services

[![Docker image](https://img.shields.io/microbadger/image-size/maslick/minimalka/latest.svg)](https://cloud.docker.com/u/maslick/repository/docker/maslick/minimalka)
[![Docker layers](https://img.shields.io/microbadger/layers/maslick/minimalka.svg?color=yellow)](https://cloud.docker.com/u/maslick/repository/docker/maslick/minimalka)
[![Docker pulls](https://img.shields.io/docker/pulls/maslick/minimalka.svg?color=green)](https://cloud.docker.com/u/maslick/repository/docker/maslick/minimalka)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)


## Features
* lightweight (~55Mb + your jar)
* using free JDK11 distribution from [Amazon Corretto 11.0.4](https://docs.aws.amazon.com/corretto/latest/corretto-11-ug/downloads-list.html)
* prebuilt image on [Dockerhub](https://cloud.docker.com/u/maslick/repository/docker/maslick/minimalka)
* you can also build it yourself (see [Dockerfile](Dockerfile))

## Build
```bash
docker build -t my-minimalka:jdk11 .
```


## Usage
Given your application jar is named ``my-cool-app.jar``, create a Dockerfile with the following contents:
```dockerfile
FROM my-minimalka:jdk11
WORKDIR /app
EXPOSE 8080
COPY my-cool-app.jar ./app.jar
CMD java $JAVA_OPTIONS -jar app.jar
```

Build and run:
```bash
docker build -t my-cool-app .
docker run -d my-cool-app
```


## Prebuilt image
You can use a prebuilt Docker image from [Dockerhub](https://cloud.docker.com/u/maslick/repository/docker/maslick/minimalka)


## Demo
```bash
git clone https://github.com/maslick/minimalka.git
cd minimalka/demo
./gradlew dockerBuild
docker run -d -p 8080:8081 -e JAVA_OPTIONS=-Dserver.port=8081 minimalka-boot
open http://`docker-machine ip default`:8080/helloworld
```
