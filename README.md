# =minimalka=
lightweight Docker image for JDK11 micro-services


[![Docker image](https://img.shields.io/microbadger/image-size/maslick/minimalka/latest.svg)](https://cloud.docker.com/u/maslick/repository/docker/maslick/minimalka)
[![Docker layers](https://img.shields.io/microbadger/layers/maslick/minimalka.svg?color=yellow)](https://cloud.docker.com/u/maslick/repository/docker/maslick/minimalka)
[![Docker pulls](https://img.shields.io/docker/pulls/maslick/minimalka.svg?color=green)](https://cloud.docker.com/u/maslick/repository/docker/maslick/minimalka)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)


## Features
* lightweight (~55Mb + your jar)
* uses free JDK11 distribution from [Amazon Corretto 11.0.4](https://docs.aws.amazon.com/corretto/latest/corretto-11-ug/downloads-list.html)
* prebuilt image on [Dockerhub](https://cloud.docker.com/u/maslick/repository/docker/maslick/minimalka) or build your own (see [Dockerfile](Dockerfile))
* S2i image: [Dockerhub](https://cloud.docker.com/repository/docker/maslick/minimalka-s2i), [Dockerfile](s2i/Dockerfile)
* integration with Openshift

## Usage
Given your application jar is named ``my-cool-app.jar``, create a Dockerfile with the following contents:
```dockerfile
FROM maslick/minimalka:jdk11
WORKDIR /app
EXPOSE 8080
COPY my-cool-app.jar ./app.jar
CMD java $JAVA_OPTIONS -jar app.jar
```

```bash
docker build -t my-cool-app .
docker run -d my-cool-app:latest
```

## Customize and build your own image
```bash
git clone https://github.com/maslick/minimalka.git && cd minimalka
vim Dockerfile
docker build -t my-minimalka:jdk11 .
```

```dockerfile
FROM my-minimalka:jdk11
WORKDIR /app
EXPOSE 8080
COPY my-cool-app.jar ./app.jar
CMD java $JAVA_OPTIONS -jar app.jar
```

```bash
docker build -t my-cool-app .
docker run -d my-cool-app:latest
```

## Demo
```bash
git clone https://github.com/maslick/minimalka.git
cd minimalka/demo
./gradlew dockerBuild
docker run -d -p 8080:8081 -e JAVA_OPTIONS=-Dserver.port=8081 minimalka-boot
open http://`docker-machine ip default`:8080/helloworld
```

## S2i binary build
This s2i image supports binary builds only. Meaning that the build stage doesn't build your jars, instead you provide already built artifacts. ***Minimalka s2i image*** will just check and copy your binaries into the resulting lightweight image.
```bash
s2i build . maslick/minimalka-s2i mycoolapp:latest
```
More or less it works in the same way as the Docker multistage builds. The resulting image is production ready and does not have the root privilage escalation flaw.

## Integration with Openshift
In a typical use-case you would have a Jenkins pipeline with several stages: ``checkout``, ``build``, ``test``, ``Build Docker image``, ``Deploy to dev``. During the ``Build Docker image`` stage you inject the already built jar (build stage) into the  ``build config`` and start the build.

```bash
oc new-build --name minimalka-runtime --docker-image maslick/minimalka-s2i --binary=true
oc start-build minimalka-runtime --from-file my-cool-app.jar
oc new-app minimalka-runtime --name my-cool-app
oc expose svc my-cool-app
```
