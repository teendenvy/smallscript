#!/bin/bash
year=`date +%Y`
month=`date -d yesterday +%m`
logs_path="/home/wwwlogs/"
d="/home/wwwlogs/"$year
dir="/home/wwwlogs/"$year"/"$month
if [ ! -d $d ]
  then
  mkdir -p $d
fi
if [ ! -d $dir ]
  then
  mkdir -p $dir
fi
mv ${logs_path}mydomain.com.log $dir/http_access_$(date -d "yesterday" +"%Y%m%d").log
kill -USR1 `cat /usr/local/nginx/logs/nginx.pid`
