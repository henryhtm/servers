useradd -m ftp-read
useradd -m ftp-write
useradd -m ftp-admin
echo -e "r1122d\nr1122d" | passwd ftp-read
echo -e "w2244r\nw2244r" | passwd ftp-write
echo -e "a1313n\na1313n" | passwd ftp-admin
echo -e "local_root=/mnt/ftp-dir" > /etc/vsftpd/user_config/ftp-admin
echo -e "write_enable=YES" >> /etc/vsftpd/user_config/ftp-admin
echo -e "local_root=/mnt/ftp-dir" > /etc/vsftpd/user_config/ftp-read
echo -e "write_enable=NO" >> /etc/vsftpd/user_config/ftp-read
echo -e "local_root=/mnt/ftp-dir" > /etc/vsftpd/user_config/ftp-write
echo -e "write_enable=YES" >> /etc/vsftpd/user_config/ftp-write
echo -e "cmds_allowed=ABOR,CWD,LIST,MDTM,MKD,NLST,PASS,PASV,PORT,PWD,QUIT,RETR,RNFR,RNTO,SIZE,STOR,TYPE,USER,REST,CDUP,HELP,MODE,NOOP,REIN,STAT,STOU,STRU,SYST,FEAT" >> /etc/vsftpd/user_config/ftp-write
