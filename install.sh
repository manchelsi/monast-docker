#!/bin/bash

## default paths
MONASTPATH=/opt/monast
HTMLPATH=/var/www/html/
BINPATH=/usr/bin
CONFIGPATH=/etc
INITD=/etc/init.d

mkdir -p $MONASTPATH
cp -rf pymon/. $MONASTPATH/
echo "MonAst instaled at ${MONASTPATH}"

mkdir -p $HTMLPATH
cp -rf *.php css image template lib js $HTMLPATH/
echo "HTML files instaled at ${HTMLPATH}"

ln -s $MONASTPATH/monast.py $BINPATH/monast
echo "Symbolic link to monast.py created at ${BINPATH}/monast"
cp pymon/monast.conf.sample /etc/monast.conf
echo "Sample monast.conf created at ${CONFIGPATH}/monast.conf"

cp contrib/init.d/rc.redhat.monast $INITD/monast
echo "Instaling init.d scripts"
