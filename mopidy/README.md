Runs the latest mopidy with tonnes of plugins and optional tools on the
archlinux base image. 

By default, this container runs `mopidy local scan` upon startup to update the
local DB. This can be overridden by either mounting your own startup script at
`/entrypoint.sh`, or changing the container entrypoint, just as you would with any
other container.

The base image has changed to Arch Linux with Mopidy 3, as I had a lot of trouble
with python3 on Ubuntu Bionic. I'll likely revert back to Ubuntu when 20.04 is
released.

Included:
  pip: Mopidy-Mobile Mopidy-Podcast Mopidy-GMusic Mopidy-Moped Mopidy-Iris Mopidy-Spotify Mopidy-Party mopidy-musicbox-webclient Mopidy-Local
  system: gstreamer1.0-plugins-base gstreamer1.0-plugins-bad gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly python-pyspotify

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
        - /path/to/your/local-storage:/root/.local/mopidy
    restart: unless-stopped
```
