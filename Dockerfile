FROM alpine:latest

ENV HOST HOSTNAME

LABEL tags="latest" \
      build_ver="DEC-26-2020"

RUN apk -U upgrade \
    && apk add -U --no-cache openssl util-linux strongswan bash \
    && rm -rf /var/cache/apk/*

RUN rm /etc/ipsec.secrets
RUN mkdir /config
RUN (cd /etc && ln -s /config/ipsec.secrets .)

ADD ./etc/* /etc/
ADD ./bin/* /usr/bin/

VOLUME /etc
VOLUME /config

EXPOSE 500/udp 4500/udp

CMD /usr/bin/start-vpn

