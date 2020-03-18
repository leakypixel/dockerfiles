Runs v0.19.0 of [snapcast](https://github.com/badaix/snapcast) on the
latest debian:stable base image.

You'll need to supply a snapserver.conf, the default can be found [here](https://github.com/badaix/snapcast/blob/master/server/etc/snapserver.conf) as a reference.

You can override the location of the config file by overriding the docker
`COMMAND` like so: `docker run leakypixel/snapserver -c /path/to/config`.


Example docker-compose config:
```
snapserver:
    image: leakypixel/snapserver
    restart: unless-stopped
    ports:
        - '1704:1704'
        - '1705:1705'
        - '1780:1780' # HTTP JSON RPC
    volumes:
        - 'fifo:/tmp/'
        - '/path/to/your/snapserver.conf:/etc/snapserver.conf'
        - '/path/to/your/snapserver/data/:/var/lib/snapserver'
```
