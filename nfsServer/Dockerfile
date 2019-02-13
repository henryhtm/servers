FROM henryhtm/servers:ubuntu18.04

#install nfs server
RUN  apt-get install -y nfs-common nfs-kernel-server
#create dir for nfs export
RUN  mkdir /dsDataDir ; chmod 777 /dsDataDir
#copy default exports file
COPY file/exports /etc/exports

COPY file/cmd.sh /mnt/cmd.sh
RUN  chmod +x /mnt/cmd.sh
CMD  ["/mnt/cmd.sh"]
