#!/bin/bash
#
# filename: webservermonitor.sh
# 功能:监控 nginx 的 php-cgi 是否正常
# 运行: webservermonitor.sh &
#

# php-cgi 监听的IP和端口
V_PHP_CGI_PORT="127.0.0.1:9000 127.0.0.1:9001"

# 日志文件
V_LOG="/home/bin/webservermonitor.log"

# 函数定义:重启nginx
function restart_nginx(){
    echo "----- `date` -----" >> $V_LOG
    echo "------------------" >> $V_LOG
    echo "`ps aux |grep 'nginx'`" >> $V_LOG
    echo "------------------" >> $V_LOG
    echo "`/etc/init.d/nginx restart`"  >> $V_LOG
    echo "`echo "nginx has been restart" | mail -s "nginx error" 471148311@qq.com`"
}

function restart_php(){
        echo "----- `date` -----" >> $V_LOG
        echo "------------------" >> $V_LOG
        echo "`ps aux |grep 'php-fpm'`" >> $V_LOG
        echo "------------------" >> $V_LOG
        echo "`/etc/init.d/php-fpm restart`"  >> $V_LOG
        echo "`echo "php has been restart" | mail -s "php error" 471148311@qq.com`"
}

# 循环执行,不采用 crontab ,国为 crontab 最小单位是分钟,时间太长了
while :
do

    # 1:先检测 nginx 主进程是否存在
    V_NGINX_NUM=`ps axu |grep 'nginx' |grep -v 'grep' |wc -l`
    if [ $V_NGINX_NUM -lt 1 ];then
        restart_nginx
        continue
    fi

    # 2:再检查php-cgi是否有进程存在
    V_PHP_CGI_NUM=`ps axu |grep 'php-fpm' |grep -v 'grep' |wc -l`
    if [ $V_PHP_CGI_NUM -lt 1 ];then
        restart_php
        continue
    fi

    # 3:再判断端口是否正常
    #for PORT in $V_PHP_CGI_PORT
    #do
    #    V_NUM=`eval "netstat -nlpt | grep '${PORT}' | wc -l"`
    #    if [ $V_NUM -lt 1 ];then
    #        restart_nginx
    #        continue
    #    fi
    #done

    # 休眠
    sleep 15
done
