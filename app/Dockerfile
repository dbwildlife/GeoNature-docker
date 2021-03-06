FROM debian:buster-slim

LABEL maintainer="BRGM"

RUN  dpkg-divert --local --rename --add /sbin/initctl

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install gnupg2 wget ca-certificates rpl pwgen sudo supervisor \
                python3 python3-dev python3-setuptools python3-pip libpq-dev \
                libgdal-dev python-gdal python-virtualenv build-essential \
                python3-wheel python3-cffi libcairo2 libpango-1.0-0 libpangocairo-1.0-0 \
                libgdk-pixbuf2.0-0 libffi-dev shared-mime-info \
                postgresql-client logrotate wait-for-it \
                locales locales-all unzip git libsm6 libxext6 libxrender-dev \
                curl software-properties-common nano vim \
    && ln -s /usr/bin/pip3 /usr/local/bin/pip \
    && apt-get clean

RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8

RUN pip3 install --upgrade pip virtualenv virtualenvwrapper
ADD ./app/utils.lib.sh /usr/local/

ADD ./app/launch_app.sh /
RUN chmod a+rx /launch_app.sh /usr/local/utils.lib.sh

RUN mkdir /home/geonatureadmin \
    && useradd -s /bin/bash -G sudo geonatureadmin \
    && chown -R geonatureadmin. /home/geonatureadmin

RUN echo "geonatureadmin ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/geonatureadmin

ADD ./app/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./bootstrap_files /mnt_bootstrap_files

RUN mkdir /geonature /bootstrap_files && chown geonatureadmin. /geonature /bootstrap_files /mnt_bootstrap_files

VOLUME /geonature

USER geonatureadmin

RUN cp /etc/skel/.bashrc /etc/skel/.bash_logout /etc/skel/.profile /home/geonatureadmin/ \
    && pip install MarkupSafe==1.0
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

WORKDIR /geonature
# TaxHub port
EXPOSE 5000
# UsersHub port
EXPOSE 5001
# GeoNature api port
EXPOSE 8000
# Atlas Api port
EXPOSE 8080


ENTRYPOINT ["/launch_app.sh"]
