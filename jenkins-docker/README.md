Jenkins image with docker installed for controlling a host docker from a jenkins
container, you'll also need to mount the docker socket like in the example.

```
jenkins:
  image: leakypixel/jenkins-docker
  restart: unless-stopped
  group_add:
    - "${DOCKER_GROUP}"
  volumes:
    - "/var/run/docker.sock:/var/run/docker.sock"
    - /path/to/your/config:/var/jenkins_home:rw"
    - "/etc/localtime:/etc/localtime:ro"
```
