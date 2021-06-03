# Librespot builder
FROM rust:latest AS librespot
ARG LIBRESPOT_VERSION=0.2.0

RUN apt-get update \
 && apt-get -y install build-essential portaudio19-dev curl unzip \
 && apt-get clean && rm -fR /var/lib/apt/lists
RUN cd /tmp \
 && curl -sLO https://github.com/librespot-org/librespot/archive/v${LIBRESPOT_VERSION}.zip \
 && unzip v${LIBRESPOT_VERSION}.zip \
 && mv librespot-${LIBRESPOT_VERSION} librespot \
 && cd librespot \
 && cargo build --release \
 && chmod +x target/release/librespot


# Base builder image for shairport and snapcast, all deps
FROM debian:stable AS build-base
RUN echo "deb http://deb.debian.org/debian buster-backports main" >> \
    /etc/apt/sources.list.d/buster-backports.list
RUN apt-get update \
    && apt-get install -y \
    build-essential \
    git \
    xmltoman \
    autoconf \
    automake \
    libtool \
    libdaemon-dev \
    libpopt-dev \
    libconfig-dev \
    libasound2-dev \
    libpulse-dev \
    avahi-daemon \
    libssl-dev \
    libsoxr-dev \
    libsndfile1-dev \
    libcrypto++-dev \
    expat \
    libboost1.71-dev \
    libexpat1 \
    libexpat1-dev \
    build-essential \
    libasound2-dev \
    libvorbisidec-dev \
    libvorbis-dev \
    libopus-dev \
    libflac-dev \
    libsoxr-dev \
    alsa-utils \
    libavahi-client-dev \
    avahi-daemon \
    expat
WORKDIR /


# Build shairport and apple ALAC
FROM build-base AS shairport
ARG ALAC_VERSION=master
ARG SHAIRPORT_SYNC_VERSION=3.3.8

RUN git clone "https://github.com/mikebrady/alac.git"
WORKDIR alac
RUN git checkout "$ALAC_VERSION" \
&& autoreconf -fi \
&& ./configure \
&& make \
&& make install

RUN git clone https://github.com/mikebrady/shairport-sync
WORKDIR shairport-sync
RUN git checkout "$SHAIRPORT_SYNC_VERSION"
RUN autoreconf -fi
RUN ./configure --with-stdout --with-pipe --with-soxr --with-avahi \
      --with-ssl=openssl --with-metadata --with-apple-alac
RUN make -j $(nproc)
RUN make install


# Build snapserver with expat support
FROM build-base AS snapserver
ARG SNAPCAST_VERSION=v0.25.0

RUN git clone --recursive https://github.com/badaix/snapcast.git
WORKDIR snapcast
RUN git checkout "$SNAPCAST_VERSION"
RUN ADD_CFLAGS="-DHAS_EXPAT=1 -lexpat" make


# Runtime image, copying artifacts from builder images
FROM debian:stable
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive \
    apt install -y \
    libexpat1 \
    libvorbisenc2 \
    libopus0 \
    libflac++6v5 \
    libsoxr0 \
    libavahi-client3 \
    libatomic1 \
    openssl \
    libasound2 \
    libconfig9 \
    libdaemon0 \
    libpopt0

COPY --from=librespot /tmp/librespot/target/release/librespot /usr/bin/
COPY --from=shairport /usr/local/bin/shairport-sync /usr/bin/shairport-sync
COPY --from=shairport /usr/local/etc/shairport-sync.conf /usr/local/etc/shairport-sync.conf
COPY --from=shairport /usr/local/lib/libalac.so.0 /lib
COPY --from=snapserver /snapcast/server/snapserver /usr/bin
RUN /usr/bin/snapserver -v
RUN apt-get clean && rm -fR /var/lib/apt/lists
EXPOSE 1704 1705 1780 5000
ENTRYPOINT ["/bin/bash","-c","/usr/bin/snapserver"]
CMD  ["-c /etc/snapserver.conf"]
