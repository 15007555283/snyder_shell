#!/bin/bash
#This script is to install PHP extensions
#Author=Snyder

#The environment variable
Extension_Name=$1
Extension_Version=$2
echo $Extension_Name
echo $Extension_Version
WGET_PATH=/opt
PHP_HOME=`whereis php | awk '{print $3}'`
echo $PHP_HOME
#Enter the extension directory
cd $WGET_PATH
wget -O $Extension_Name-$Extension_Version.tgz https://pecl.php.net/get/$Extension_Name-$Extension_Version.tgz

Extension_Install() {
   cd $WGET_PATH
   tar -xzvf $Extension_Name-$Extension_Version.tgz
   cd $Extension_Name-$Extension_Version && $PHP_HOME/bin/phpize && ./configure --with-php-config=$PHP_HOME/bin/php-config
   make && make install
}

Extension_So() {
   SO_NAME=`$Extension_Name.so`
   if grep -Fxq "extension=$SO_NAME" $PHP_HOME/etc/php.ini
      then
         echo "extension=$SO_NAME exist "
      else
         echo -e "extension=$SO_NAME" >> $PHP_HOME/etc/php.ini
   fi
}

if [ ! -s $Extension_Name-$Extension_Version.tgz ];then
    echo "$Extension_Name-$Extension_Version,资源不存在";
else
   Extension_Install
   Extension_So
   /etc/init.d/php-fpm restart
fi
