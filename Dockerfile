FROM debian:latest
MAINTAINER Nicolas Steinmetz <public+docker@steinmetz.fr>

RUN apt update \
	&& DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends apt-utils \
	&& DEBIAN_FRONTEND=noninteractive apt upgrade -y --no-install-recommends \
	&& DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends apt-utils python-setuptools ca-certificates apt-transport-https dialog \
	&& easy_install supervisor

COPY repo/influxdb.list /etc/apt/sources.list.d/influxdb.list
ADD https://repos.influxdata.com/influxdb.key /tmp/influxdb.key
RUN apt-key add /tmp/influxdb.key \
	&& apt update \
	&&  EBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends influxdb kapacitor chronograf

COPY conf/config.toml /opt/chronograf/
COPY conf/influxdb.conf /etc/influxdb/influxdb.conf
COPY conf/kapacitor.conf /etc/kapacitor/kapacitor.conf

RUN mkdir -p /data/influxdb /data/kapacitor /data/chronograf \
	&& chown influxdb: -R /data/influxdb \
	&& chown kapacitor: -R /data/kapacitor \
	&& chown chronograf: -R /data/chronograf \
	&& mkdir -p /etc/supervisor/conf.d

COPY supervisor/supervisord.conf /etc/supervisor/
COPY supervisor/influxdb.conf /etc/supervisor/conf.d/
COPY supervisor/chronograf.conf /etc/supervisor/conf.d/
COPY supervisor/kapacitor.conf /etc/supervisor/conf.d/

EXPOSE 8086 8083 10000

COPY entrypoint/influxdb-chronograf-entrypoint.sh /
ENTRYPOINT ["/influxdb-chronograf-entrypoint.sh"]