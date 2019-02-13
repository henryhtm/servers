This doc tells you how to use this image.
1. Before running this container, you have to get the following ready:
    * A data directory for sharing files
    * Use "chmod +r" to set the data directory readable(&writable if necessary)
    * Configure firewall of your host to open both TCP&UDP port 111,2049,9402

2. Use the following command to run the server:
    docker run --privileged -v /host/data/dir/:/dsDataDir -p 111:111/udp -p 111:111/tcp -p 2049:2049/tcp -p 2049:2049/udp -p 9402:9402/udp -p 9402:9402/tcp -d CONTAINER_NAME
    
