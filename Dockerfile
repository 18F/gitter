# VERSION               0.0.1

# USAGE
# docker run --rm -e "ACCESS_KEY=CHANGEME" -e "SECRET_KEY=CHANGME" -v ~/path/to/csv/directory:/csv gitter-docker /csv/csvfile.csv bucketname

FROM      ubuntu:14.04
MAINTAINER V. David Zvenyach <vladlen.zvenyach@gsa.gov>

RUN apt-get install -y wget python-setuptools git
RUN wget http://downloads.sourceforge.net/project/s3tools/s3cmd/1.5.2/s3cmd-1.5.2.tar.gz && tar xvfz s3cmd-1.5.2.tar.gz && cd s3cmd-1.5.2 && sudo python setup.py install && cd ..

COPY ./gitter.sh /
COPY ./s3cfg.conf /
RUN mkdir -p /responses

WORKDIR /

ENTRYPOINT ["/gitter.sh"]