#!/bin/bash
# getWXMessage.sh - A Bash script to retrieve the lastest APRS weather
# packet for the specified station from the wxqa.com search engine using
# curl. It will be saved as the specified filename. Then grepped for the
# last position report packet, which is saved to DATFILE
#
# (C) 2015 KB4OID Labs, A division of Kodetroll Heavy Industries
#
# Author: Kodetroll (KB4OID)
# Date: January 2015
#

# load the config file
. ./local.cfg

# Fetch the page, silently, and save it to file
curl ${URL} -s -o ${FILE}

# grep the page, find the first line of packets and save this to DATFILE
cat ${FILE} | grep "$IDW>" | head -n1 > ${DATFILE}
