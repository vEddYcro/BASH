#!/bin/bash
chkconfig NetworkManager off
chkconfig network on
service NetworkManager stop
sleep 5
killall dhclient
service network start
yum install httpd* xinetd syslinux* dhcp* tftp-server wget dnsmasq -y
cd /usr/share/syslinux/
cp pxelinux.0 menu.c32 memdisk mboot.c32 chain.c32 /var/lib/tftpboot/
chkconfig xinetd on
chkconfig httpd on
chkconfig dhcpd on
chkconfig tftp on
chkconfig dnsmasq on
mkdir /iso
mkdir /media/iso
cd /iso
wget http://sourceforge.net/projects/dban/files/dban/dban-2.3.0/dban-2.3.0_i586.iso/download
mv download dban-2.3.0_i586.iso
mv dban-2.3.0_i586.iso dban.iso
echo "/iso/dban.iso   /media/iso   iso9660   ro,loop  0 0" >> /etc/fstab
mount -a
cd /media/iso
mkdir /var/lib/tftpboot/dban
cd /var/lib/tftpboot/dban
cp /media/iso/dban.bzi .
mkdir /var/lib/tftpboot/pxelinux.cfg
echo "default menu.c32" >> /var/lib/tftpboot/pxelinux.cfg/default
echo "prompt 0" >> /var/lib/tftpboot/pxelinux.cfg/default
echo "timeout 300" >> /var/lib/tftpboot/pxelinux.cfg/default
echo "ONTIMEOUT local" >> /var/lib/tftpboot/pxelinux.cfg/default
echo "menu title ########## PXE Boot Menu ##########" >> /var/lib/tftpboot/pxelinux.cfg/default
echo "LABEL dban" >> /var/lib/tftpboot/pxelinux.cfg/default
echo "MENU LABEL DBAN Hard Drive Wipe" >> /var/lib/tftpboot/pxelinux.cfg/default
echo "KERNEL dban/dban.bzi" >> /var/lib/tftpboot/pxelinux.cfg/default
echo 'append initrd dban/dban.bzi root=/dev/ram0 init=rc nuke="dwipe"' >> /var/lib/tftpboot/pxelinux.cfg/default
echo 'default-lease-time 600;'  >> /etc/dhcp/dhcpd.conf
echo 'max-lease-time 7200;'  >> /etc/dhcp/dhcpd.conf
echo 'log-facility local7;'  >> /etc/dhcp/dhcpd.conf
echo 'subnet 192.168.100.0 netmask 255.255.255.0 {'  >> /etc/dhcp/dhcpd.conf
echo 'range 192.168.100.1 192.168.100.253;'  >> /etc/dhcp/dhcpd.conf
echo 'option domain-name-servers 192.168.100.254 ;'  >> /etc/dhcp/dhcpd.conf
echo 'option domain-name "example.com";'  >> /etc/dhcp/dhcpd.conf
echo 'option routers 192.168.100.254;'  >> /etc/dhcp/dhcpd.conf
echo 'option broadcast-address 192.168.100.255;'  >> /etc/dhcp/dhcpd.conf
echo 'default-lease-time 600;'  >> /etc/dhcp/dhcpd.conf
echo 'max-lease-time 7200;'  >> /etc/dhcp/dhcpd.conf
echo '}'  >> /etc/dhcp/dhcpd.conf
echo 'allow booting;' >> /etc/dhcp/dhcpd.conf
echo 'allow bootp;'  >> /etc/dhcp/dhcpd.conf
echo 'option option-128 code 128 = string;'  >> /etc/dhcp/dhcpd.conf
echo 'option option-129 code 129 = text;'  >> /etc/dhcp/dhcpd.conf
echo 'next-server 192.168.100.254;'  >> /etc/dhcp/dhcpd.conf
echo 'filename "pxelinux.0";'  >> /etc/dhcp/dhcpd.conf
echo "127.0.0.1   localhost" > /etc/hosts
echo "192.168.100.254 eraser.example.com eraser" >> /etc/hosts
service dhcpd restart
service httpd restart
service xinetd restart
service dnsmasq restart
echo "nameserver 192.168.100.254" > /etc/resolv.conf

