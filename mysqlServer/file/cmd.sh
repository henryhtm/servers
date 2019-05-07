#!/bin/sh
CONF_FILE="/etc/mysql/mysql.conf.d/mysqld.cnf"
if [ "$EXT_PORT"X != ""X ] ; then
  sed -i "/^port/i\port\t\t= $EXT_PORT" $CONF_FILE && sed -i "/^port/n; /^port/d" $CONF_FILE
fi
if [ "$DATA_DIR"X != ""X ] ; then
  sed -i "/^datadir/i\datadir\t\t= $DATA_DIR" $CONF_FILE && sed -i "/^datadir/n; /^datadir/d" $CONF_FILE
  chmod +222 $DATA_DIR
  if [ -e "$DATA_DIR/ibdata1" ] ; then
    grep "A temporary password" /var/log/mysql/error.log
  else
    mysqld --initialize
    grep "A temporary password" /var/log/mysql/error.log
  fi
fi

/etc/init.d/mysql start &
while true
do
  sleep 2
done

