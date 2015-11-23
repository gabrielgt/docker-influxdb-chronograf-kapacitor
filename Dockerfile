FROM debian:latest
MAINTAINER Nicolas Steinmetz <public+docker@steinmetz.fr>
RUN sed -i -e "s/httpredir/ftp2\.fr/g" /etc/apt/sources.list
RUN sed -i -e "s/main/main contrib non-free/g" /etc/apt/sources.list
RUN apt update && DEBIAN_FRONTEND=noninteractive apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y apt-utils python-setuptools ca-certificates
RUN easy_install supervisor
ADD https://s3.amazonaws.com/influxdb/influxdb_0.9.5_amd64.deb /tmp/influxdb_0.9.5_amd64.deb
RUN dpkg -i /tmp/influxdb_0.9.5_amd64.deb
ADD https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf_0.3.2_amd64.deb /tmp/chronograf_0.3.2_amd64.deb
RUN dpkg -i /tmp/chronograf_0.3.2_amd64.deb
COPY conf/config.toml /opt/chronograf/
RUN mkdir -p /opt/influxdb/instance/etc
COPY conf/influx.conf /opt/influxdb/instance/etc/
RUN chown influxdb: -R /opt/influxdb/instance
RUN mkdir -p /etc/supervisor/conf.d
COPY supervisor/supervisord.conf /etc/supervisor/
COPY supervisor/influxdb.conf /etc/supervisor/conf.d/
COPY supervisor/chronograf.conf /etc/supervisor/conf.d/
EXPOSE 8086 8083 10000
COPY entrypoint/influxdb-chronograf-entrypoint.sh /
ENTRYPOINT ["/influxdb-chronograf-entrypoint.sh"]
