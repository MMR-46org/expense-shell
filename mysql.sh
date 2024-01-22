mysql_password=$1
source common.sh

if [ -z "$mysql_password" ];then
  echo input mysql_password is missing &>>log_file
  exit 1
fi

head "disable the module mysql"
dnf module disable mysql -y &>>log_file
stat $?

head "configure the repo file "
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
stat $?

head "install the mysql community"
dnf install mysql-community-server -y &>>log_file
stat $?

head "enable and start mysqld"
systemctl enable mysqld &>>log_file
systemctl start mysqld &>>log_file
stat $?

head "secure installation"
mysql_secure_installation --set-root-pass ${mysql_password} &>>log_file
stat $?
