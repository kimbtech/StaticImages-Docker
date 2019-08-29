#!/bin/bash

# get latest zip url
zipurl="https://github.com/KIMB-technologies/PassApp/archive/master.zip"

# download latest zip
curl -L $zipurl -o $1/pass/l.zip
# unzip
mkdir $1/pass/u
unzip -q $1/pass/l.zip -d $1/pass/u

# load relevant
mkdir $1/pass/web
mv $1/pass/u/PassApp-master/* $1/pass/web/

# delete other
rm -fr $1/pass/l.zip $1/pass/u

# => data for container is in folder pass/web

# clean up pass/web
rm -rf $1/pass/web/README.md 

# docker build
docker build -t pass $1/pass/
docker images
docker tag pass kimbtech/servers:pass
docker push kimbtech/servers:pass

# clean more
rm -fr $1/pass/web
