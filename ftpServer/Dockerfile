FROM henryhtm/servers:ubuntu18.04
RUN apt-get install -y vsftpd \
    && mkdir /mnt/ftp-dir/ -pv \
    && chmod 777 /mnt/ftp-dir/ \
    && mkdir /etc/vsftpd/user_config -pv \
    && rm /var/lib/apt/* -rf

COPY file/adduser.sh /root/add_ftp_user.sh

COPY file/vsftpd.conf /etc/
RUN chmod +x /root/add_ftp_user.sh
CMD /root/add_ftp_user.sh; chmod 777 /mnt/ftp-dir/; service vsftpd start; while true; do sleep 2; done
