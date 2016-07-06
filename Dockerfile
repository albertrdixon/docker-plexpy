FROM alpine
MAINTAINER Albert Dixon <albert@dixon.rocks>

ENTRYPOINT ["/sbin/tini", "--", "/sbin/entry"]
CMD ["/sbin/start"]
VOLUME ["/data"]
EXPOSE 8181

ENV PATH=/src/plexpy:$PATH \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    UPDATE_INTERVAL=24h

ADD https://github.com/albertrdixon/escarole/releases/download/v0.2.3/escarole-linux.tgz /es.tgz
COPY ["entry", "start", "/sbin/"]
COPY escarole.yml /

RUN chmod +rx /sbin/entry /sbin/start \
    && tar xvzf /es.tgz -C /bin \
    && apk add -U --progress --purge \
        git \
        python \
        tini \
    && addgroup -g 1000 plexpy \
    && adduser -s /sbin/nologin -D -h /src -G plexpy -u 1000 plexpy
