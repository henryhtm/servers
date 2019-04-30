This doc shows how to use this image.

Before running this container, you have to get the following things ready:
   * A data directory with a sub directory(such as : /ftproot_dir/ftpdata_dir/) for upload/download files .
   * the root diretory shouldn't be writable, use "chmod 555 ftproot_dir" to set it to be readable and excutable .
   * the data diretory should be writable, use "chmod 666 ftpdata_dir" to set it to be readable and writable .
   * Configure firewall of your host to open TCP port 21 .

The simplest way to use this image is using the following command(Don't forget configuring the firewall to open TCP port 20):
   docker run -d -p 20-21:20-21 -v /ftproot_dir/:/mnt/ftp-dir CONTAINER_NAME

If you want to configure user and password, please specify the following USERLIST parameter:
   USERLIST=TYPE1,USER1,PASSWD1 TYPE2,USER2,PASSWD2

If you want to run the ftp server in PASSIVE mode , please specify the following parameters(Don't forget configuring the firewall to open TCP port minport~maxport):
   FTPMODE=PASV 
   FTPADDR=ipaddr of your server
   PASVPRANGE=minport,maxport
   
   
Examples of command:
   * Run the ftp server with the default config(PORT mode, random user and password)
      docker run -d -p 20-21:20-21 -v /ftproot_dir/:/mnt/ftp-dir CONTAINER_NAME
   
   * Run the ftp server in PORT mode and with an admin user:sample-admin passwd:smpwd112233:
      docker run -d -p 20-21:20-21 -e "USERLIST=AD,sample-admin,smpwd112233" -v /ftproot_dir/:/mnt/ftp-dir CONTAINER_NAME
   
   * Run the ftp server in PASV mode, port ranges (10330-10360), adminUser(padmin1:passwd1a) and readonlyUser(rduser:pwd4rd):
      docker run -d -p 21:21 -p 10330-10360:10330-10360 -e "USERLIST=AD,padmin1,passwd1a RD,rduser,pwd4rd" -v /ftproot_dir/:/mnt/ftp-dir CONTAINER_NAME

After running the container, you can get the FTP information by the following command:
    docker logs [containerID]
  
