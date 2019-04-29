This doc tells you how to use this image.
1. Before running this container, you have to get the following ready:
    * A data directory for upload/download files .
    * Use "chmod 777 data_dir" to set the data directory readable and writable .
    * Configure firewall of your host to open TCP port 21 and UDP port 20 .

2. Use the following command to run the server:
    docker run -d -p 20:20/udp -p 21:21 -v /host/data/dir/:/mnt/ftp-dir CONTAINER_NAME
   You can also specify the user list of ftp as follow:
    docker run -d -p 20:20/udp -p 21:21 -e "USERLIST=ad,adminUser,adpasswd wr,writeUser,wrPasswd" -v /host/data/dir/:/mnt/ftp-dir CONTAINER_NAME
3. You can check the FTP users' info by command:
    docker logs [containerID]
  
