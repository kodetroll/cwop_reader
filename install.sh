#!/bin/bash
# install.sh - Manual install script for installing the cwop-reader
# tool suite into it's functional location
#
BIN=/usr/local/sbin
ETC=/etc/cwop-reader
mkdir -p ${ETC}
cp ./local.cfg ${ETC}
mkdir -p ${BIN}
cp get*.sh ${BIN}
cp aprs_wx_parse ${BIN}

