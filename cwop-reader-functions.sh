#!/bin/bash
# cwop-reader-functions.sh - A Bash script function linbary to support
# the cwop_reader application suite.
#
# (C) 2015 KB4OID Labs, A division of Kodetroll Heavy Industries
#
# Author: Kodetroll (KB4OID)
# Date: February 2015
#

# This will search for and load the config file
function LoadConfig () {

  CONF="cwop-reader.conf"

  LOCAL="./"
  ETC="/etc/cwop-reader/"
  USR="/usr/local/etc/cwop-reader/"
  SHARE="/usr/share/cwop-reader/"

  TEST=""
  CFG=""

  for DIR in "$ETC" "$USR" "$SHARE" "$LOCAL"
  do
    TEST="$DIR/$CONF"
    # test for the existance of the config file
    if [ -e "$TEST" ]; then
        CFG=$TEST
    fi
  done

  # load the config file
  if [ ! -z $CFG ];  then
      . $CFG
  else
     echo "Config file not found exiting!"
      exit 1
  fi
}

# This will search for and generate the path for the parser
function FindParser () {

  FILE="aprs_wx_parse"

  PATHD=""
  LOCAL="./"
  USR="/usr/local/etc/cwop-reader/"
  SHARE="/usr/share/cwop-reader/"

  TEST=""
  WXP=""

  for DIR in "$PATHD" "$USR" "$SHARE" "$LOCAL"
  do
    TEST="$DIR$FILE"
    # test for the existance of the file
    if [ -e "$TEST" ]; then
        WXP=$TEST
    fi
  done

  if [ ! -z "$WXP" ]; then
    PARSER=$WXP
  fi
}

# This will ensure that the tmpdir is always ready and waiting!
function ChkTmp () {

  if [ ! -e "$TMPDIR" ]; then
    echo "Temp folder \"$TMPDIR\" does NOT exist, creating!"
    mkdir -p ${TMPDIR}
  fi
}

# This will call the wxqa site, fetch the specified file for the specified
# station ID and save it to a temp file location. It will then grep this
# for the aprs wxformat info and save this to a second temp file. This
# last file is loaded and parsed for the parameter by the calling script.
function GetWxMessage () {

  # Fetch the page, silently, and save it to file
  curl ${1} -s -o ${2}

  # grep the page, find the first line of packets and save this to DATFILE
  cat ${2} | grep "$IDW>" | head -n1 > ${3}

}

LoadConfig

FindParser

ChkTmp


