FROM henryhtm/servers:ubuntu18.04
RUN apt-get install -y vsftpd \
    && mkdir /mnt/ftp-dir/data-dir -pv \
    && chmod 777 /mnt/ftp-dir/data-dir \
    && mkdir /etc/vsftpd/user_config -pv \
    && rm /var/lib/apt/* -rf

COPY file/adduser.sh /root/add_ftp_user.sh

COPY file/vsftpd.conf /etc/
RUN chmod +x /root/add_ftp_user.sh
RUN /root/add_ftp_user.sh
CMD chmod 777 /mnt/ftp-dir/data-dir;service vsftpd start; while true;do sleep 2; done
