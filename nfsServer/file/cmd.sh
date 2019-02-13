#!/bin/sh
trap "echo 'stopped by TERM';/etc/init.d/nfs-kernel-server stop;echo 'Done.';exit 0;" TERM

#sent the port of mountd to 9402
echo "mountd 9402/udp" >> /etc/services
echo "mountd 9402/tcp" >> /etc/services
#copy user export file if existed.
cp /dsDataDir/exports /etc/
chmod +r /etc/exports

rpcbind start
/etc/init.d/nfs-kernel-server start ;

while true ;
do
sleep 2 ;
done
