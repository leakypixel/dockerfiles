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


# Build gmrender-resurrect
FROM build-base AS gmrender
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive \
    apt install -y \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-tools \
    gstreamer1.0-alsa \
    libupnp-dev \
    libgstreamer1.0-dev
WORKDIR /tmp
RUN git clone https://github.com/hzeller/gmrender-resurrect.git
WORKDIR /tmp/gmrender-resurrect
RUN ./autogen.sh && \
    ./configure && \
    make && \
    make install


# Runtime image, copying artifacts from builder images
FROM debian:stable
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive \
    apt install -y \
    libc6 \
    libglib2.0-0 \
    libgstreamer1.0-0 \
    libixml10 \
    libupnp13 \
    lsb-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-plugins-bad 

COPY --from=gmrender /usr/local/bin/gmediarender /usr/bin
COPY --from=gmrender /usr/local/share/gmediarender /usr/local/share/gmediarender
RUN /usr/bin/gmediarender --version
RUN apt-get clean && rm -fR /var/lib/apt/lists
EXPOSE 1704 1705 1780 5000
ENTRYPOINT ["/bin/bash","-c","/usr/bin/gmediarender"]
CMD  ["--gstout-audiopipe=audioresample ! audioconvert ! audio/x-raw,rate=48000,channels=2,format=S16LE ! wavenc ! filesink location=/tmp/dlna-fifo", "--logfile=stderr"]

