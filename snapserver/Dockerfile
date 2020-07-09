FROM rust:1.42 AS librespot

RUN apt-get update \
 && apt-get -y install build-essential portaudio19-dev curl unzip \
 && apt-get clean && rm -fR /var/lib/apt/lists

ARG LIBRESPOT_VERSION=0.1.1

RUN cd /tmp \
 && curl -sLO https://github.com/librespot-org/librespot/archive/v0.1.1.zip \
 && unzip v${LIBRESPOT_VERSION}.zip \
 && mv librespot-${LIBRESPOT_VERSION} librespot \
 && cd librespot \
 && cargo build --release \
 && chmod +x target/release/librespot

FROM debian:stable

ARG snapcast_version=0.20.0

RUN  apt-get update \
  && apt-get install -y wget ca-certificates \
  shairport-sync
RUN  wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapserver_${snapcast_version}-1_amd64.deb
RUN  dpkg -i snapserver_${snapcast_version}-1_amd64.deb \
  ;  apt-get update \
  && apt-get -f install -y \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf snapserver_${snapcast_version}-1_amd64.deb
COPY --from=librespot /tmp/librespot/target/release/librespot /usr/local/bin/
RUN /usr/bin/snapserver -v
EXPOSE 1704 1705 1780
ENTRYPOINT ["/bin/bash","-c","/usr/bin/snapserver"]
CMD  ["-c /etc/snapserver.conf"]
