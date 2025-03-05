# Build stage 0
FROM erlang:23.3.4.13-alpine

RUN apk add --no-cache libcrypto1.1

RUN mkdir /buildroot

WORKDIR /buildroot

COPY . zeus

WORKDIR zeus

RUN escript rebar clean get-deps compile generate && \
    chmod 755 build/bin/server

COPY ["etc/app.config", "release/files/server.conf", "release/files/vm.args", "build/etc"]

# Build stage 1
FROM alpine:3.14.6

RUN apk add --no-cache openssl && \
    apk add --no-cache libcrypto1.1 && \
    apk add --no-cache ncurses-libs && \
    apk add --no-cache libstdc++ && \
    apk add --no-cache bash

COPY --from=0 /buildroot/zeus/build /zeus

VOLUME [ "/zeus/var/db", "/zeus/log" ]

WORKDIR /zeus

USER root

EXPOSE 30000

CMD /bin/bash -c 'export home=/zeus && bin/server start && trap : TERM INT; (while true; do sleep 1000; done) & wait'
