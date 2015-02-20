#!/bin/bash
# getWind.sh - A BASH Script to retrieve the latest APRS WX packet over the
# internet from a specified CWOP weather station via the wxqa.com website,
# parse it for the specified parameter (in this case Wind Speed) and print
# this value to STDOUT.
#
# (C) 2015 KB4OID Labs, A division of Kodetroll Heavy Industries
#
# Author: Kodetroll (KB4OID)
# Date: January 2015
#

# Include the cwop reader functions file (depends on being in the path)
. cwop-reader-functions.sh

# fetch the message from the server, save locally and grep the APRS WX packet
GetWxMessage $URL $TMPFILE $TMPDAT

# parse the APRS WX packet for the wind speed value (-s -or- --speed)
OUT=`cat ${TMPDAT} | ${PARSER} --quiet --speed`

# print this to STDOUT
echo $OUT
