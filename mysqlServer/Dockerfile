FROM henryhtm/servers:ubuntu16.04
RUN  debconf-set-selections <<< "mysql-server mysql-server/root_password password YOURPASSWD"
RUN  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password YOURPASSWD"
RUN  apt-get install -y mysql-server mysql-client libmysqlclient-dev
RUN  sed -i '/^datadir/i\datadir\t\t= \/mnt\/mysql' /etc/mysql/mysql.conf.d/mysqld.cnf && sed -i '/^datadir/n;/^datadir/d' /etc/mysql/mysql.conf.d/mysqld.cnf
CMD  ["/mnt/cmd.sh"]
