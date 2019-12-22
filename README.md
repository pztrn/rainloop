# Rainloop webmail Docker container

This repository contains Rainloop webmail Docker container build scripts and neccessary configuration files.

## Persistent things

There are some things that should be preserved between container's restarts. Please, add new volume for ``/var/www/rainloop/data`` directory.