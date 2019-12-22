# Rainloop webmail Docker container

This repository contains Rainloop webmail Docker container build scripts and neccessary configuration files.

## Persistent things

There are some things that should be preserved between container's restarts. Please, add new volume for ``/var/www/rainloop/data`` directory.

If you're binding directory except of creating volume please do proper ``chown``:

```shell
chown -R 100:101 /dir/with/data
```