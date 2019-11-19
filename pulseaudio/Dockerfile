# Modified from jess/pulseaudio
# Removed PA configs in favour of mounting them at runtime
# Added zeroconf PA module for avahi publishing
FROM debian:sid-slim as build
LABEL maintainer "Craig Fletcher <hi@leakypixel.net>"

RUN apt-get update && apt-get install -y \
	alsa-utils \
	libasound2 \
	libasound2-plugins \
	pulseaudio \
	pulseaudio-module-zeroconf \
	pulseaudio-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/pulseaudio
RUN useradd --create-home --home-dir $HOME pulseaudio \
	&& usermod -aG audio,pulse,pulse-access pulseaudio \
	&& chown -R pulseaudio:pulseaudio $HOME

WORKDIR $HOME
USER pulseaudio
FROM build
ENTRYPOINT [ "pulseaudio" ]
CMD [ "--log-level=4", "--log-target=stderr", "-v"]
