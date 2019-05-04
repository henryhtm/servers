FROM henryhtm/servers:ubuntu16.04
RUN  debconf-set-selections <<< "mysql-server mysql-server/root_password password YOURPASSWD"
RUN  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password YOURPASSWD"
RUN  apt-get install -y mysql-server mysql-client libmysqlclient-dev
CMD  ["/mnt/cmd.sh"]
