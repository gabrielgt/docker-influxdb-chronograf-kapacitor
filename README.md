# InfluxDB & Chronograf container #

## Overview ##

Dockerfile to have a [Docker](https://www.docker.com) container running both [InfluxDB](https://influxdb.com) and [Chronograf](https://influxdb.com/chronograf/index.html)

It runs on latest Debian version with the help of supervisord. Fore more details, see :

* /etc/supervisor/supervisord.conf 
* /etc/supervisor/conf.d/influxdb.conf
* /etc/supervisor/conf.d/chronograf.conf

InfluxDB data are so far in /opt/influxdb/instance and configuration file is in /opt/influxdb/instance/etc/influx.conf

## Release Notes ##

* 20151001 : Update to InfluxDB 0.9.4.2 & Chronograf 0.2
* 20150920 : Initial version with InfluxDB 0.9.4.1 & Chronograf 0.1

## How to run the container ##

I published an image on docker hub [nsteinmetz/influxdb-chronograf](https://hub.docker.com/r/nsteinmetz/influxdb-chronograf/) you can use.

```
#!shell

docker run -d -t -p 8083:8083 -p 8086:8086 -p 10000:10000  nsteinmetz/influxdb-chronograf

```

## How to build your container ? ##

```
#!shell

docker build -t <yourname>/influxdb:<yourtag> .

```

## How to run your container ? ##

```
#!shell

docker run -d -t -p 8083:8083 -p 8086:8086 -p 10000:10000  <yourname>/influxdb:<yourtag>

```

Enjoy :)