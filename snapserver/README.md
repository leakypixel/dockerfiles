Runs v0.15 of [snapcast](https://github.com/badaix/snapcast) on the
debian-debootstrap:amd64-jessie-slim base image.

```
snapserver:
    image: leakypixel/snapserver
    restart: unless-stopped
    ports:
        - '1704:1704'
        - '1705:1705'
    volumes:
        - 'fifo:/tmp/'
        - '/path/to/your/config:/etc/default/snapserver'
```
