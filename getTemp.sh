#!/bin/bash
# getTemp.sh - A BASH Script to retrieve the latest APRS WX packet over the
# internet from a specified CWOP weather station via the wxqa.com website,
# parse it for the specified parameter (in this case Temperature) and print
# this value to STDOUT.
#
# (C) 2015 KB4OID Labs, A division of Kodetroll Heavy Industries
#
# Author: Kodetroll (KB4OID)
# Date: January 2015
#

# load the config file
. ./local.cfg

# fetch the message from the server, save locally and grep the APRS WX packet
. ./getWxMessage.sh

# parse the APRS WX packet for the temperature value (-t -or- --temp)
OUT=`cat ${DATFILE} | ./aprs_wx_parse --quiet --temp`

# print this to STDOUT
echo $OUT
