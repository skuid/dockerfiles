FROM python:2-alpine

MAINTAINER Micah Hausler, <micah@skuid.com>

RUN apk -U add \
    g++ \
    gcc \
    git \
    libffi-dev \
    openssl-dev \
    python-dev

RUN pip install elastalert==0.1.12

ENV AWS_KEY_ID ""
ENV AWS_SECRET_KEY ""

ADD config.yaml config.yaml
VOLUME /rules

#CMD python elastalert/elastalert.py [--debug] [--verbose] [--start <timestamp>] [--end <timestamp>] [--rule <filename.yaml>] [--config <filename.yaml>]
ENTRYPOINT ["/usr/local/bin/elastalert"]
CMD ["--debug"]
