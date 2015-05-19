# the library's version
VERSION:=4.1.1

# tools
SHELL = /bin/sh
MKDIR = mkdir

all:
	cc -g -Wall -g -O2 -Iheaders -DWITH_POSIX -o coap_client client.c -L. -lcoap
