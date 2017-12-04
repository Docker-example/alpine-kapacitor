FROM alpine:3.6

LABEL MAINTAINER="Aurelien PERRIER <perrie_a@etna-alternance.net>"
LABEL APP="kapacitor"
LABEL APP_VERSION="1.3.3"
LABEL APP_REPOSITORY="https://github.com/influxdata/kapacitor/releases"
LABEL APP_DESCRIPTION="alerting"

ENV TIMEZONE Europe/Paris
ENV KAPACITOR_VERSION 1.3.3
ENV GOSU_VERSION 1.10

# Installing packagies
RUN apk add --no-cache --virtual .build-deps wget tar

# Downloading binaries    
RUN wget --no-check-certificate -q https://dl.influxdata.com/kapacitor/releases/kapacitor-${KAPACITOR_VERSION}-static_linux_amd64.tar.gz
RUN wget --no-check-certificate -q -O /usr/bin/gosu https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64
    
COPY ./files/kapacitor.conf /etc/kapacitor/kapacitor.conf
COPY ./scripts/start.sh start.sh

# Extract archive
RUN tar -C . -xzf kapacitor-${KAPACITOR_VERSION}-static_linux_amd64.tar.gz && \
    rm -f kapacitor-*/kapacitor.conf && \
    chmod +x kapacitor-*/* && \
    cp -a kapacitor-*/* /usr/bin/ && \
    rm -rf *.tar.gz* kapacitor-* && \
    addgroup kapacitor && \
    adduser -s /bin/false -G kapacitor -S -D kapacitor && \
    apk del .build-deps
    
EXPOSE 9092

VOLUME /var/lib/kapacitor

ENTRYPOINT ["./start.sh"]