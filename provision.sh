#!/bin/bash

VENDOR_DIR="/vagrant/vendor"
TITAN_VERSION='titan-0.5.2-hadoop2'
TITAN_DOWNLOAD_URL="http://s3.thinkaurelius.com/downloads/titan/$TITAN_VERSION.zip"
TITAN_DIR="$VENDOR_DIR/$TITAN_VERSION"

# accept the oracle jdk license
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

add-apt-repository ppa:webupd8team/java
apt-get -y -q update
apt-get -y -q install unzip oracle-java8-installer

if [ ! -d $TITAN_DIR ]; then
	echo "Directory $TITAN_DIR not found, downloading $TITAN_DOWNLOAD_URL"
	wget --directory-prefix "$VENDOR_DIR" -nv -N "$TITAN_DOWNLOAD_URL" \
		&& unzip -q -o -d "$VENDOR_DIR" "$VENDOR_DIR/$TITAN_VERSION.zip"
fi


# "$TITAN_DIR"/bin/titan.sh -c cassandra-es start