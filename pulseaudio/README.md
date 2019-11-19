Runs pulseaudio as a system-wide daemon, includes zeroconf for LAN discovery.

* Modified from jess/pulseaudio
* Removed PA configs in favour of mounting them at runtime
* Added zeroconf PA module for avahi publishing


Work in progress - working for me, but I'm playing around with dbus + avahi in
containers for this too.

```
pulseaudio:
    image: leakypixel/pulseaudio
    privileged: true
    network_mode: host
    restart: unless-stopped
    environment:
        - 'DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket'
    volumes:
        - '/path/to/pulse/config:/etc/pulse'
        - '/var/run/dbus:/var/run/dbus'
        - '/etc/machine-id:/etc/machine-id'
        - 'fifo:/tmp/:Z'
        - '/etc/localtime:/etc/localtime:ro'
        - '/run/dbus/system_bus_socket:/run/dbus/system_bus_socket'
```
