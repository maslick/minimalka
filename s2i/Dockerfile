FROM maslick/minimalka:jdk11

ARG USER=user
ARG S2IDIR=/s2i
ARG APPDIR=/app

LABEL maintainer="Pavel Maslov <pavel.masloff@gmail.com>" \
      io.k8s.description="S2I runner for lightweight JDK11 based micro-services" \
      io.k8s.display-name="Lightweight JDK11 runner image" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="runner,java,jdk11,amazon,corretto" \
      io.openshift.s2i.scripts-url="image://$S2IDIR/bin"

COPY bin $S2IDIR/bin
ENV HOME=$APPDIR

RUN mkdir $APPDIR \
    && addgroup $USER \
    && useradd -r -u 1001 -g $USER -d $HOME $USER \
    && chown -R $USER:$USER $HOME \
    && chown -R $USER:$USER $S2IDIR \
    && chmod -R +x $S2IDIR/bin

WORKDIR $HOME
EXPOSE 8080
USER 1001

CMD ["$S2IDIR/bin/run"]