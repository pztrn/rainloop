# Rainloop webmail Docker container

This repository contains Rainloop webmail Docker container build scripts and neccessary configuration files.

## Persistent things

There are some things that should be preserved between container's restarts. Please, add new volume for ``/var/www/rainloop/data`` directory.

If you're binding directory except of creating volume please do proper ``chown``:

```shell
chown -R 100:101 /dir/with/data
```

## Use with docker-compose

You may use this image with docker-compose like that:

```yaml
version: "2.4"

services:
  rainloop:
    restart: always
    image: "pztrn/rainloop:1.16.0"
    volumes:
      - "/root/rainloop/data:/var/www/rainloop/data"
    ports:
      - "5480:80"
    cpus: 2
    mem_limit: 1G
    memswap_limit: 0
```
