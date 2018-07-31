FROM python:3.4.6-wheezy
#FROM continuumio/anaconda3

MAINTAINER Fabio Nonato

ARG http_proxy
ARG https_proxy

# Create alias
RUN echo "alias ll='ls -al'" >> /root/.bashrc

RUN [ -n “$http_proxy” ] && echo “Acquire::http::proxy \“${http_proxy}\“;” > /etc/apt/apt.conf; \
   [ -n “$https_proxy” ] && echo “Acquire::https::proxy \“${https_proxy}\“;” >> /etc/apt/apt.conf; \
   [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf; exit 0

#RUN apt-get install libc-dev -y

RUN apt-get -y update  && apt-get install -y \
  python3-dev \
  libpng-dev \
  apt-utils \
  python-psycopg2 \
  python-dev \
  postgresql-client \
&& rm -rf /var/lib/apt/lists/*

RUN pip --proxy ${http_proxy} install \
	 --upgrade setuptools\
   msgpack\
   pystan

RUN pip --proxy ${http_proxy}  install \
	 cython\
	 numpy\
	 matplotlib\
	 pystan\
	 fbprophet\
	 psycopg2\
	 sqlalchemy

 RUN pip --proxy ${http_proxy}  install \
 jupyter


CMD /bin/bash -c "jupyter notebook --allow-root --ip='*' --no-browser --NotebookApp.token=''"
