Node image running a markdown rendering script with a dumb watch task. Reads
from `/app/mdrender/content` and outputs to `/app/mdrender/output`. Alpha
quality would be putting it lightly.

```
mdrender:
  image: leakypixel/mdrender
  restart: unless-stopped
  volumes:
    - "/path/to/your/markdown/files:/app/mdrender/content:ro"
    - "/path/to/your/output/dir:/app/mdrender/output:rw"
    - "/etc/localtime:/etc/localtime:ro"
```
