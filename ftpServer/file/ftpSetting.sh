#!/bin/sh
if [ "$USERLIST"X = ""X ] ; then
        dtNum=$(("1"$(date +%s)%1000000))
        nnNum=$(("1"$(date +%N)%100000))
        rdType="WR"
        rdName1="ftpUser"$(($dtNum%1234))$(($nnNum%1111))
        rdName2="ftpAdmin"$(($dtNum%2345))$(($nnNum%2222))
        rdPasswd1="Upwd"$(($dtNum%45678))$(($nnNum%3333))
        rdPasswd2="Upwd"$(($dtNum%56789))$(($nnNum%4444))
        export USERLIST="$rdType,$rdName1,$rdPasswd1 ad,$rdName2,$rdPasswd2"
fi
if [ "$FTPMODE"X = "PASV"X -o "$FTPMODE"X = "pasv"X ] ; then
        echo -e "The mode of ftp-server is: PASV"
        export FTPMODE="PASV"
        echo "pasv_enable=YES" >> /etc/vsftpd.conf
        if [ "$FTPADDR"X != ""X ] ; then
                echo -e "ExternIP is "$FTPADDR
                echo "pasv_address=$FTPADDR" >> /etc/vsftpd.conf
                echo "pasv_addr_resolve=yes" >> /etc/vsftpd.conf
        fi
        if [ "$PASVPRANGE"X != ""X ] ; then
                minPort=$(echo $PASVPRANGE | cut -d , -f 1)
                maxPort=$(echo $PASVPRANGE | cut -d , -f 2)
                echo "pasv_min_port=$minPort" >> /etc/vsftpd.conf
                echo "pasv_max_port=$maxPort" >> /etc/vsftpd.conf
                echo -e "DataPort range is: "$minPort" ~ "$maxPort
        fi
else
        echo -e "The mode of ftp-server is: PORT"
        export FTPMODE="PORT"
        echo "port_enable=YES" >> /etc/vsftpd.conf
        echo "connect_from_port_20=YES" >> /etc/vsftpd.conf
fi
if [ "$SSL"X != "NO"X ] && [ "$SSL"X != "no"X ] ; then
        echo "ssl_enable=YES" >> /etc/vsftpd.conf
else
        echo "ssl_enable=NO" >> /etc/vsftpd.conf
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
                        echo -e "----------Readonly User----------"
                        echo -e "    UserName: "$uName"\n    Passwd: "$uPwd
                        echo -e "---------------------------------\n"
                        echo -e "local_root=/mnt/ftp-dir" > /etc/vsftpd/user_config/$uName
                        echo -e "write_enable=NO" >> /etc/vsftpd/user_config/$uName
                elif [ "$uType"x = "AD"x -o "$uType"x = "ad"x ] ; then
                        echo -e "-----------Admin User-----------"
                        echo -e "    UserName: "$uName"\n    Passwd: "$uPwd
                        echo -e "--------------------------------\n"
                        echo -e "local_root=/mnt/ftp-dir" > /etc/vsftpd/user_config/$uName
                        echo -e "write_enable=YES" >> /etc/vsftpd/user_config/$uName
                elif [ "$uType"x = "WR"x -o "$uType"x = "wr"x ] ; then
                        echo -e "---------Writable User---------"
                        echo -e "    UserName: "$uName"\n    Passwd: "$uPwd
                        echo -e "-------------------------------"
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

