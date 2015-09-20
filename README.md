# InfluxDB & Chronograf container #

Dockerfile to have a [Docker](https://www.docker.com) container running both [InfluxDB](https://influxdb.com) and [Chronograf](https://influxdb.com/chronograf/index.html)

It runs on latest Debian version with the help of supervisord. See :

* /etc/supervisor/supervisord.conf 
* /etc/supervisor/conf.d/influxdb.conf
* /etc/supervisor/conf.d/chronograf.conf fore more details.

## How to build your container ? ##

```
#!shell

docker run -d -t -p 8083:8083 -p 8086:8086 -p 10000:10000  <yourname>/influxdb:<yourtag>

```

## How to run your container ? ##

```
#!shell

docker run -d -t -p 8083:8083 -p 8086:8086 -p 10000:10000  <yourname>/influxdb:<yourtag>

```

Enjoy :)
