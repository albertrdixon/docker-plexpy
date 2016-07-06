FROM alpine
MAINTAINER Albert Dixon <albert@dixon.rocks>

ENTRYPOINT ["tini", "--", "/sbin/entry"]
EXPOSE 8181

ADD https://github.com/albertrdixon/escarole/releases/download/v0.2.3/escarole-linux.tgz /es.tgz
COPY ["entry", "start", "/sbin/"]
COPY escarole.yml /

RUN chmod +rx /sbin/entry /sbin/start \
    && tar xvzf /es.tgz -C /bin \
    && apk install --update --purge \
        git \
        python \
        tini
