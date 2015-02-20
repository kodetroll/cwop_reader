#!/bin/bash
# install.sh - Manual install script for installing the cwop-reader
# tool suite into it's functional locations. Shouldn't necessary to
# run this. a 'sudo make install' should suffice.
#
# (C) 2015 KB4OID Labs, A division of Kodetroll Heavy Industries
#
# Author: Kodetroll (KB4OID)
# Date: January 2015
#

# Define our target folders for the install actions
BIN=/usr/local/sbin
ETC=/etc/cwop-reader

# Create the etc config folder for cwop-reader
mkdir -p ${ETC}
# copy the default config file to there
cp cwop-reader.conf ${ETC}

# ensure aprs_wx_parse is up-to-date
make cleanall; make

# create the BIN folder (if it doesn't already exist)
mkdir -p ${BIN}

# copy the scripts and aprs_wx_parse to the BIN folder
cp cwop-reader-functions.sh ${BIN}
cp get*.sh ${BIN}
cp aprs_wx_parse ${BIN}

