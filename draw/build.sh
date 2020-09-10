#!/bin/bash

# set via travis secret
# 	GET_VERSION_API="https://api.mypage/github/latest-version-drawio.php"
# get latest zip url
phpcode="echo file_get_contents('$GET_VERSION_API');"
zipurl=$(php -r "$phpcode")

# download latest zip
curl -L $zipurl -o $1/draw/l.zip
# unzip
mkdir $1/draw/u
unzip -q $1/draw/l.zip -d $1/draw/u

# load relevant
mkdir $1/draw/web
mv $1/draw/u/jgraph-drawio-*/src/main/webapp/* $1/draw/web/

# delete other
rm -fr $1/draw/l.zip $1/draw/u

# => data for container is in folder draw/web

# clean up draw/web
rm -rf $1/draw/web/META-INF $1/draw/web/WEB-INF $1/draw/web/dropbox.html $1/draw/web/github.html $1/draw/web/gitlab.html $1/draw/web/onedrive*.html $1/draw/web/yarn.lock

# docker build
docker build -t drawio $1/draw/
docker images
docker tag drawio kimbtech/servers:drawio
docker push kimbtech/servers:drawio

# clean more
rm -fr $1/draw/web
