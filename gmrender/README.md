Runs gmrender-resurrect on the latest debian:stable base image.

You can override the output by overriding the docker
`COMMAND` like so: `docker run leakypixel/gmrender your-gmediarender-args`.


Example docker-compose config:
```
gmrender:
    image: leakypixel/gmrender
    restart: unless-stopped
    network_mode: host # needed for upnp for now at least
    environment:
      - 'DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket'
    volumes:
      - '/etc/localtime:/etc/localtime:ro'
      - '/run/dbus/system_bus_socket:/run/dbus/system_bus_socket' # For avahi publishing
      - 'fifo:/tmp/:rw'
      - '/etc/machine-id:/etc/machine-id:ro'
    entrypoint: gmediarender
    command: ["--gstout-audiopipe=audioresample ! audioconvert ! audio/x-raw,rate=48000,channels=2,format=S16LE ! wavenc ! filesink location=/tmp/dlna-fifo", "--logfile=stdout"]
```
