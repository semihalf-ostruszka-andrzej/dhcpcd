# Makefile based on BSD's pmake.
# Our mk stubs also work with GNU make.
# Copyright 2008 Roy Marples <roy@marples.name>

PROG=		dhcpcd
SRCS=		arp.c client.c common.c configure.c dhcp.c dhcpcd.c duid.c \
		info.c interface.c ipv4ll.c logger.c signal.c socket.c
MAN=		dhcpcd.8

VERSION=	3.1.9
CLEANFILES=	version.h dhcpcd.8

BINDIR=		${PREFIX}/sbin

.SUFFIXES:	.in

MK=		mk
include ${MK}/os.mk
include ${MK}/cc.mk
include ${MK}/prog.mk

# os.mk should define this, but heh
INFOD?=		/var/db

LDADD+=		${LIBRESOLV} ${LIBRT}
CFLAGS+=	-DINFODIR=\"${INFOD}\" ${FORK} ${RC}

# As version.h is generated by us, hardcode the depend correctly.
${SRCS}:	version.h
version.h:
	echo "#define VERSION \"${VERSION}\""> version.h

.in:
	sed 's:@PREFIX@:${PREFIX}:g; s:@INFODIR@:${INFOD}:g' $< > $@
