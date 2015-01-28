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

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

all: aprs_wx_parse 

aprs_wx_parse: $(OBJ)
	gcc -o $@ $^ $(CFLAGS)

.PHONY: clean

cleanall:
	rm -f aprs_wx_parse *.o *~ core

clean:
	rm -f *.o *~ core aprs.dat last.txt
