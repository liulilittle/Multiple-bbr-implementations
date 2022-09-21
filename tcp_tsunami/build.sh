wget https://raw.githubusercontent.com/liberal-boy/tcp_tsunami/master/tcp_tsunami.c
echo "obj-m:=tcp_tsunami.o" > Makefile
make -C /lib/modules/$(uname -r)/build M=`pwd` modules CC=/usr/bin/gcc
insmod tcp_tsunami.ko
cp -rf ./tcp_tsunami.ko /lib/modules/$(uname -r)/kernel/net/ipv4
depmod -a
modprobe tcp_tsunami
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=tsunami" >> /etc/sysctl.conf
sysctl -p

sysctl net.ipv4.tcp_congestion_control
