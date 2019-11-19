Runs the latest mopidy with tonnes of plugins and optional tools on the ubuntu bionic base image.

Included:
  pip: Mopidy-Mobile Mopidy-Podcast Mopidy-GMusic Mopidy-Moped Mopidy-Iris Mopidy-Spotify Mopidy-Party mopidy-musicbox-webclient Mopidy-Local-SQLite
  apt: upmpdcli gstreamer1.0-plugins-base gstreamer1.0-plugins-bad gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly libspotify12 python-spotify

Use in a docker-compose.yml:
```
mopidy:
    image: leakypixel/mopidy
    ports:
        - "6680:6680"
        - "6600:6600"
    volumes:
        - fifo:/tmp/
        - /path/to/you/music:/media/music
        - /path/to/your/config:/root/.config/mopidy
    restart: unless-stopped
```
