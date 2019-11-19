FROM multiarch/debian-debootstrap:amd64-jessie-slim

ARG  snapcast_version=0.16.0

RUN  apt-get update \
  && apt-get install -y wget ca-certificates \
  && rm -rf /var/lib/apt/lists/*
RUN  wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapserver_${snapcast_version}_amd64.deb
RUN  dpkg -i snapserver_${snapcast_version}_amd64.deb \
  ;  apt-get update \
  && apt-get -f install -y \
  && rm -rf /var/lib/apt/lists/*
RUN snapserver -v
EXPOSE 1704 1705
ENTRYPOINT ["/bin/bash","-c","source /etc/default/snapserver && snapserver $SNAPSERVER_OPTS"]