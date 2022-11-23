#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi

cur_dir=$(pwd)
Domain=$1


Version='1.9'
. lnmp.conf
. include/main.sh
. include/init.sh
. include/mysql.sh
. include/mariadb.sh
. include/php.sh
. include/nginx.sh
. include/apache.sh
. include/end.sh
. include/only.sh
. include/multiplephp.sh

Get_Dist_Name

if ["${Domain}" = ""]; then
    Echo_Red "Domain is Must Params."
    exit 1
fi

if [ "${DISTRO}" = "unknow" ]; then
    Echo_Red "Unable to get Linux distribution name, or do NOT support the current distribution."
    exit 1
fi

clear
echo "+------------------------------------------------------------------------+"
echo "|          Create SSL${Version} for ${DISTRO} Linux Server, Written by Licess          |"
echo "+------------------------------------------------------------------------+"
echo "|        Script Dependency For LNMP      |"
echo "+------------------------------------------------------------------------+"
echo "|           Script author Snyder         |"
echo "+------------------------------------------------------------------------+"

Init_Certbot()
{
    if [ "$PM" = "yum" ]; then
        yum install -y certbot
    elif [ "$PM" = "apt" ]; then
        apt-get install -y certbot
    fi
}
Init_Certbot()

exit
