#!/bin/sh
if [ "$USERLIST"X = ""X ] ; then
        export USERLIST="WR,ftp-read,rd1354 ad,ftp-admin,a1313n"
fi
if [ "$FTPMODE"X = "PASV"X -o "$FTPMODE"X = "pasv"X ] ; then
        export FTPMODE="PASV"
        echo "pasv_enable=YES" >> /etc/vsftpd.conf
        if [ "$FTPADDR"X != ""X ] ; then
                echo "pasv_address=$FTPADDR" >> /etc/vsftpd.conf
                echo "pasv_addr_resolve=yes" >> /etc/vsftpd.conf
        fi
        if [ "$PASVPRANGE"X != ""X ] ; then
                minPort=$(echo $PASVPRANGE | cut -d , -f 1)
                maxPort=$(echo $PASVPRANGE | cut -d , -f 2)
                echo "pasv_min_port=$minPort" >> /etc/vsftpd.conf
                echo "pasv_max_port=$maxPort" >> /etc/vsftpd.conf
        fi
else
        export FTPMODE="PORT"
        echo "port_enable=YES" >> /etc/vsftpd.conf
        echo "connect_from_port_20=YES" >> /etc/vsftpd.conf
fi
for userInfo in $USERLIST
do
        uType=$(echo $userInfo|cut -d , -f 1)
        uName=$(echo $userInfo|cut -d , -f 2)
        uPwd=$(echo $userInfo|cut -d , -f 3)
        if [ "$uType"x = ""x ] || [ "$uName"x = ""x ] || [ "$uPwd" = ""x ]; then
                echo "The form of [$userInfo] is Error."
        else
                if [ "$uType"x = "RD"x -o "$uType"x = "rd"x ] ; then
                        echo "Add Read User:"$uName" Passwd:"$uPwd
                        echo -e "local_root=/mnt/ftp-dir" > /etc/vsftpd/user_config/$uName
                        echo -e "write_enable=NO" >> /etc/vsftpd/user_config/$uName
                elif [ "$uType"x = "AD"x -o "$uType"x = "ad"x ] ; then
                        echo "Add Admin User:"$uName" Passwd:"$uPwd
                        echo -e "local_root=/mnt/ftp-dir" > /etc/vsftpd/user_config/$uName
                        echo -e "write_enable=YES" >> /etc/vsftpd/user_config/$uName
                elif [ "$uType"x = "WR"x -o "$uType"x = "wr"x ] ; then
                        echo "Add Write User:"$uName" Passwd:"$uPwd
                        echo -e "local_root=/mnt/ftp-dir" > /etc/vsftpd/user_config/$uName
                        echo -e "write_enable=YES" >> /etc/vsftpd/user_config/$uName
                        echo -e "cmds_allowed=ABOR,CWD,LIST,MDTM,MKD,NLST,PASS,PASV,PORT,PWD,QUIT,RETR,RNFR,RNTO,SIZE,STOR,TYPE,USER,REST,CDUP,HELP,MODE,NOOP,REIN,STAT,STOU,STRU,SYST,FEAT" >> /etc/vsftpd/user_config/$uName
                else
                        echo "Invalid UserType:"$uType
                        continue
                fi
                useradd -m $uName
                echo -e $uPwd"\n"$uPwd | passwd $uName
        fi
done
