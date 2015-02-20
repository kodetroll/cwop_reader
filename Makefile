####################################################################
# 
# Makefile for aprs_wx_parse.c - An APRS WX Packet parser in C
#
# (C) 2015 KB4OID Labs, A division of Kodetroll Heavy Industries
#
# Author: Kodetroll
#

CC=gcc
CFLAGS=-I.
#DEPS = C.h
OBJ = aprs_wx_parse.o 
PROGRAMS= aprs_wx_parse cwop-reader-functions.sh getTemp.sh getWind.sh getRain.sh getTime.sh
prefix=/usr/local


%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

all: aprs_wx_parse 

aprs_wx_parse: $(OBJ)
	gcc -o $@ $^ $(CFLAGS)
   
install: all
	test -d $(prefix) || mkdir $(prefix)
	test -d $(prefix)/sbin || mkdir -p $(prefix)/sbin
	for prog in $(PROGRAMS); do \
		install -m 0755 $$prog $(prefix)/bin; \
	done
	test -d /etc/cwop-reader || mkdir -p /etc/cwop-reader
	install -m 0644 cwop-reader.conf /etc/cwop-reader

#    	test -d $(prefix)/share || mkdir $(prefix)/share
#    	test -d $(prefix)/share/cwop-reader || mkdir -p $(prefix)/share/cwop-reader
#    	for icon in *.xbm; do \
#    	  install -m 0644 $$icon $(prefix)/share/cwop-reader; \
#    	done


.PHONY: clean

cleanall:
	rm -f aprs_wx_parse *.o *~ core

clean:
	rm -f *.o *~ core aprs.dat last.txt
