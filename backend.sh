mysql_password=$1
component=backend

source common.sh


head "disable the nodejs"
dnf module disable nodejs -y &>>log_file
if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

head "enable the nodejs"
dnf module enable nodejs:18 -y &>>log_file
if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi


head "install the nodejs"
dnf install nodejs -y &>>log_file
if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

head "config the backend service"
cp backend.service /etc/systemd/system/backend.service &>>log_file
if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

head "adding the user"
useradd expense &>>log_file
if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi


head "install the software"
npm install &>>log_file
if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

head "reload the restart the backend"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl start backend &>>log_file
if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

head "install mysql"
dnf install mysql -y &>>log_file
if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi

head "reload the schema"
mysql -h mysql.madhanmohanreddy.tech -uroot -p${mysql_password} < /app/schema/backend.sql &>>log_file
if [ $? -eq 0 ];then
  echo SUCCESS
else
  echo FAILURE
  exit 1
fi