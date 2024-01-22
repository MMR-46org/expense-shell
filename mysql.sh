mysql_password=$1
source common.sh

if [ -z "$mysql_password" ];then
  echo input mysql_password is missing
  exit 1
fi

head "disable the module mysql"
dnf module disable mysql -y
stat (){
  if [ $? -eq 0 ];then
    echo success
  else
    echo failure
    exit 1
  fi
}

head "configure the repo file "
cp mysql.repo /etc/yum.repos.d/mysql.repo
stat(){
  if [ $? -eq 0 ]; then
    echo success
  else
    echo failure
    exit 1
  fi
}

head "install the mysql community"
dnf install mysql-community-server -y
stat(){
  if [ $? -eq 0 ]; then
    echo success
  else
    echo failure
  fi
}

head "enable and start mysqld"
systemctl enable mysqld
systemctl start mysqld
stat() {
  if [ $? -eq 0 ];then
    echo success
  else
    echo failure
  fi
}

head "secure installation"
mysql_secure_installation --set-root-pass ${mysql_password}
stat() {
  if [ $? -eq 0 ]; then
    echo success
  else
    echo failure
  fi
}
