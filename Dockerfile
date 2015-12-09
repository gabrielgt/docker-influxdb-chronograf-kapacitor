FROM debian:latest
MAINTAINER Nicolas Steinmetz <public+docker@steinmetz.fr>

RUN sed -i -e "s/httpredir/ftp2\.fr/g" /etc/apt/sources.list
RUN sed -i -e "s/main/main contrib non-free/g" /etc/apt/sources.list
RUN apt update && DEBIAN_FRONTEND=noninteractive apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y apt-utils python-setuptools ca-certificates apt-transport-https
RUN easy_install supervisor

COPY repo/influxdb.list /etc/apt/sources.list.d/influxdb.list
ADD https://repos.influxdata.com/influxdb.key /tmp/influxdb.key
RUN apt-key add /tmp/influxdb.key
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y influxdb kapacitor

ADD https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf_0.4.0_amd64.deb /tmp/chronograf_0.4.0_amd64.deb
RUN dpkg -i /tmp/chronograf_0.4.0_amd64.deb

COPY conf/config.toml /opt/chronograf/
COPY conf/influxdb.conf /etc/influxdb/influxdb.conf
COPY conf/kapacitor.conf /etc/kapacitor/kapacitor.conf

RUN mkdir -p /data/influxdb /data/kapacitor /data/chronograf
RUN chown influxdb: -R /data/influxdb
RUN chown kapacitor: -R /data/kapacitor
RUN chown chronograf: -R /data/chronograf

RUN mkdir -p /etc/supervisor/conf.d
COPY supervisor/supervisord.conf /etc/supervisor/
COPY supervisor/influxdb.conf /etc/supervisor/conf.d/
COPY supervisor/chronograf.conf /etc/supervisor/conf.d/
COPY supervisor/kapacitor.conf /etc/supervisor/conf.d/

EXPOSE 8086 8083 10000

COPY entrypoint/influxdb-chronograf-entrypoint.sh /
ENTRYPOINT ["/influxdb-chronograf-entrypoint.sh"]