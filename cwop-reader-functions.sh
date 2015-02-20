#!/bin/bash
# cwop-reader-functions.sh - A Bash script function linrary to support
# the cwop_reader application suite.
#
# (C) 2015 KB4OID Labs, A division of Kodetroll Heavy Industries
#
# Author: Kodetroll (KB4OID)
# Date: February 2015
#
function LoadConfig () {

  LOCAL="./"
  ETC="/etc/cwop-reader/"
  USR="/usr/local/etc/cwop-reader/"
  SHARE="/usr/share/cwop-reader/"
  CONF="cwop-reader.conf"
  TEST=""
  CFG=""
  for DIR in "$ETC" "$USR" "$SHARE" "$LOCAL"
  do
    TEST="$DIR/$CONF"
#    echo "Looking for $CONF in $DIR"
    # test for the existance of the config file
    if [ -e "$TEST" ]; then
#        echo "Config found!"
        CFG=$TEST
#    else
#        echo "Config NOT found!"
    fi
  done

#  echo "CFG: $CFG"
  # load the config file
  if [ ! -z $CFG ];  then
      . $CFG
  else
     echo "Config file not found exiting!"
      exit 1
  fi
}

function ChkTmp () {

  if [ ! -e "$TMPDIR" ]; then
    echo "Temp folder \"$TMPDIR\" does NOT exist, creating!"
    mkdir -p ${TMPDIR}
  fi
}

function GetWxMessage () {
  #URL=$1
  #TMPFILE=$2
  #TMPDAT=$3

  #echo "URL: $URL"
  #echo "TMPDAT: $TMPDAT"
  #echo "TMPFILE: $TMPFILE"

  # Fetch the page, silently, and save it to file
  curl ${1} -s -o ${2}

  # grep the page, find the first line of packets and save this to DATFILE
  cat ${2} | grep "$IDW>" | head -n1 > ${3}

}

LoadConfig

ChkTmp

