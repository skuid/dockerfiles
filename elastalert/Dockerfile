FROM python:2-alpine

MAINTAINER Micah Hausler, <micah@skuid.com>

LABEL "OS_version"= "alpine:3.4"
LABEL "Python_version"= "2.7.13" 

RUN apk -U add \
    g++ \
    gcc \
    git \
    libffi-dev \
    openssl-dev \
    python-dev

#RUN pip install elastalert==0.1.12
RUN pip install git+git://github.com/yelp/elastalert@1134c9ea2028b8246479a66b16a45cc71631e980

ENV AWS_KEY_ID ""
ENV AWS_SECRET_KEY ""

ADD config.yaml config.yaml
VOLUME /rules

#CMD python elastalert/elastalert.py [--debug] [--verbose] [--start <timestamp>] [--end <timestamp>] [--rule <filename.yaml>] [--config <filename.yaml>]
ENTRYPOINT ["/usr/local/bin/elastalert"]
CMD ["--debug"]
