Runs the latest monero daemon on the archlinux-yaourt base image.

```
docker run -d \
	-p 18080:18080 -p 18081:18081 \
  	-v /etc/localtime:/etc/localtime:ro \
  	-v /path/to/your/config/:/home/yaourt/.bitmonero/:Z \
	--restart=unless-stopped \
	--name=monerod \
	monerod
```
