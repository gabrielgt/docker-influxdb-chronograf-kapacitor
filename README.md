# InfluxDB, Chronograf and Kapacitor container #

## Overview ##

Dockerfile to have a [Docker](https://www.docker.com) container running [InfluxDB](https://influxdata.com/time-series-platform/influxdb) and [Chronograf](https://influxdata.com/time-series-platform/chronograf) and [Kapacitor](https://influxdata.com/time-series-platform/kapacitor)

It runs on latest Debian version with the help of supervisord. Fore more details, see :

* /etc/supervisor/supervisord.conf 
* /etc/supervisor/conf.d/influxdb.conf
* /etc/supervisor/conf.d/chronograf.conf
* /etc/supervisor/conf.d/kapacitor.conf

InfluxDB data are in /data/influxdb/ and configuration file is in /etc/influxdb/influxdb.conf
Chronograf data are in /data/chronograf/ and configuration file is in /opt/chronograf/config.toml
Kapacitor data are in /data/kapacitor/ and configuration file is in /etc/kapacitor/kapacitor.conf

So you can use docker volumes for persistent data, with something like:

```
docker run -d -t -v /path/to/influxdb/data:/data/influxdb -v /path/to/chronograf/data:/data/chronograf /path/to/kapacitor/data:/data/kapacitor -p 8083:8083 -p 8086:8086 -p 10000:10000  nsteinmetz/influxdb-chronograf
```

## Release Notes ##

* 20160208 : All packages are retrieved from InfluxData Debian Repo :-)
* 20160206 : Update for 0.10.0 release as Chronograf still not yet in [debian repo](https://github.com/influxdata/kapacitor/issues/222)
* 20151209 : Add debian repo so that we use latest stable version of InfluxDB and Kapacitor - Chronograf is not yet in repo.
* 20151209 : Update to InfluxDB 0.9.6 & Chronograf 0.4.0 & Kapacitor 0.2.0 + add /data/{influxdb,chronograf,kapacitor}/ to mount volumes.
* 20151123 : Update to InfluxDB 0.9.5 & Chronograf 0.3.2
* 20151001 : Update to InfluxDB 0.9.4.2 & Chronograf 0.2
* 20150920 : Initial version with InfluxDB 0.9.4.1 & Chronograf 0.1

## How to run the container ##

I published an image on docker hub [nsteinmetz/influxdb-chronograf](https://hub.docker.com/r/nsteinmetz/influxdb-chronograf/) you can use.

```
docker run -d -t -p 8083:8083 -p 8086:8086 -p 10000:10000  nsteinmetz/influxdb-chronograf

```

## How to build your container ? ##

```
docker build -t <yourname>/influxdb:<yourtag> .

```

## How to run your container ? ##

```
docker run -d -t -p 8083:8083 -p 8086:8086 -p 10000:10000  <yourname>/influxdb:<yourtag>

```

Enjoy :)