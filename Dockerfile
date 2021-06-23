FROM lsiobase/guacgui

# package version
ARG GPODDER_VERSION="3.10.20"

# env variables
ARG DEBIAN_FRONTEND="noninteractive"
ENV APPNAME="gPodder"
LABEL maintainer="xthursdayx"

# install build & runtime packages
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
       at-spi2-core \
       dbus \
       default-dbus-session-bus \
       ffmpeg \
       gir1.2-gtk-3.0 \
       gir1.2-ayatanaappindicator3-0.1 \
       gir1.2-webkit2-4.0 \
       git \
       help2man \
       intltool \
       jq \
       libgtk-3-0 \
       locales-all \
       normalize-audio \
       python3 \
       python3-cairo \
       python3-dbus \
       python3-gi \
       python3-gi-cairo \
       python3-pip \
       python3-simplejson \
       python3-setuptools \
       wget \
       xfonts-75dpi \
       xfonts-100dpi && \
# install PyPI deps
    pip3 install --no-cache-dir \
	   mygpoclient==1.8 \
	   podcastparser==0.6.6 \
	   requests[socks]==2.25.1 \
	   urllib3==1.26.5 \
	   html5lib==1.1 \
	   mutagen==1.45.1 \
	   eyed3 \
	   youtube_dl &&\
# clone gPodder
    git clone https://github.com/gpodder/gpodder.git /app && \
    cd /app/gpodder && \
    git checkout $GPODDER_VERSION && \
# clean up
    cd / && \
    apt-get clean && \
    apt-get purge -y git wget && \
    rm -rf \
       /tmp/* \
       /var/lib/apt/lists/* \
       /var/tmp/*

COPY root/ /

VOLUME /config
EXPOSE 3389 8080
