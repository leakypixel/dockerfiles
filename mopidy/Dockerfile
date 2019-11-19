FROM ubuntu:bionic
RUN  apt-get update
RUN  apt-get install -y software-properties-common
RUN  apt-add-repository universe
RUN  apt-get install -y wget
RUN  wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add -
RUN  wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/stretch.list
RUN  add-apt-repository ppa:jean-francois-dockes/upnpp1 -y
RUN  apt-get update --fix-missing
RUN  apt-get install -y python-pip upmpdcli mopidy build-essential gstreamer1.0-plugins-base gstreamer1.0-plugins-bad gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly libspotify12 python-spotify
RUN  apt-get remove -y python-pyasn1
RUN  pip install Mopidy-Mobile Mopidy-Podcast Mopidy-GMusic Mopidy-Moped Mopidy-Iris Mopidy-Spotify Mopidy-Party mopidy-musicbox-webclient Mopidy-Local-SQLite

EXPOSE 6600 6680
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
