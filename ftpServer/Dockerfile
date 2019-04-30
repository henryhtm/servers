FROM henryhtm/servers:ubuntu18.04
RUN apt-get install -y vsftpd \
    && mkdir /mnt/ftp-dir/ -pv \
    && chmod 777 /mnt/ftp-dir/ \
    && mkdir /etc/vsftpd/user_config -pv \
    && rm /var/lib/apt/* -rf

COPY file/ftpSetting.sh /root/ftpSetting.sh

COPY file/vsftpd.conf /etc/
RUN chmod +x /root/ftpSetting.sh
CMD /root/ftpSetting.sh; chmod 555 /mnt/ftp-dir; chmod 777 /mnt/ftp-dir/*; service vsftpd start 1&>>/dev/null; while true; do sleep 2; done
