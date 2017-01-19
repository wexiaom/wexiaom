#!/bin/bash
clear
rm -f sb.sh
echo "
============================================================="
echo
echo -e "\e[1;35m\n                 一键搭建tinyproxy+自动生成模式(微信wexiaom)
\e[0m"./tinyproxy -c tinyproxy.conf
echo "============================================================="
sleep 5
rm -rf ./tinyproxy*
yum -y install unzip
wget --no-check-certificate https://raw.githubusercontent.com/chinazr930/xx/master/tinyproxy.zip
unzip ./tinyproxy.zip
chmod 0777 tinyproxy
read -p "输入你要用的端口（请确保端口未被占用）：" port
sleep 1
read -p "输入你喜欢的验证头：" yanzheng
echo "User root
Group root
Port $port
yanzhengtou \"$yanzheng\"
Timeout 600
DefaultErrorFile \"/usr/share/tinyproxy/default.html\"
StatFile \"/usr/share/tinyproxy/stats.html\"
Logfile \"/var/log/tinyproxy.log\"
LogLevel Critical 
PidFile \"/var/run/tinyproxy.pid\"
MaxClients 100
MinSpareServers 5
MaxSpareServers 20
StartServers 10
MaxRequestsPerChild 0
">tinyproxy.conf
sleep 1
./tinyproxy -c tinyproxy.conf
echo "如无错误则安装正常"
read -p "联通请输入1，移动请输入2：" yys
if [ $yys -eq 1 ]; then
host='wap.10010.com'
elif [ $yys -eq 2 ];then 
host='rd.go.10086.cn'
else
echo "没有电信"
fi
sleep 1
echo "正在生成模式"
myip=`wget http://ipecho.net/plain -O - -q ; echo`
echo "mode=wap;
listen_port=65080;
daemon=on;
worker_proc=0;
uid=3004;
#无限流量手机一手货源诚招代理
#微信wexiaom
http_ip=$myip;
http_port=$port;
https_connect=on;
https_ip=$myip;
https_port=$port;
dns_tcp=http;
dns_listen_port=65053;
dns_url=\"119.29.29.29\";
http_del=\"Host,X-Online-Host\";
https_del=\"Host,X-Online-Host\";
#欢迎加入汇众科技微商团队，创始人微信：wexiaom
http_first=\"[method] http://$host[uri] [version]\\r\\nHost: $host\\r\\n$yanzheng: [host]\\r\\n\";
https_first=\"CONNECT $host:443 [version]\\r\\nHost: $host\\r\\n$yanzheng: [host]\\r\\n\";
">tiny.conf
clear
echo "
==================================================="
echo 正在创建下载链接...
echo -e "\n下载地址：`curl --upload-file ./tiny.conf https://transfer.sh/tiny.conf`"
echo 
echo
echo 请复制上方链接到浏览器下载tiny云代理模式。
echo
echo -e "\e[1;31m\n注意！百度搜索“IP”结果应显示：$myip\e[0m"
