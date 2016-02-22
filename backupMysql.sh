#!/bin/sh
year=`date +%Y`
month=`date +%m`
day=`date +%d`
hour=`date +%H`
sqlname="data"$year"_"$month"_"$day"_"$hour".sql"
year1=`date +"%Y_%m_%d_%H" -d "-2 days"`".sql"
dir="/home/mysql"
if [ ! -d $dir ]
 then
mkdir -p $dir
fi
user="root"
passwd="qwerty"
dbname="download"
mysqldump -u$user -p$passwd $dbname > $dir/$sqlname
tar -jcvf $dir/$sqlname".tar.bz2" $dir/$sqlname
rm -f $dir/$sqlname
rm -rf $dir/$year1".tar.bz2"
