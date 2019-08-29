#!/bin/bash

# get latest zip url
zipurl="https://github.com/keeweb/keeweb/archive/gh-pages.zip"

# download latest zip
curl -L $zipurl -o $1/kee/l.zip
# unzip
mkdir $1/kee/u
unzip -q $1/kee/l.zip -d $1/kee/u

# load relevant
mkdir $1/kee/web
mv $1/kee/u/keeweb-gh-pages/* $1/kee/web/

# delete other
rm -fr $1/kee/l.zip $1/kee/u

# => data for container is in folder kee/web

# clean up kee/web
rm -rf $1/kee/web/CNAME 

# docker build
docker build -t kee $1/kee/
docker images
docker tag kee kimbtech/servers:kee
docker push kimbtech/servers:kee

# clean more
rm -fr $1/kee/web
