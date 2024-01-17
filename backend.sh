mysql_password=$1
component=backend

source common.sh

head "disable the nodejs"
dnf module disable nodejs -y &>>log_file
echo $?

head "enable the nodejs"
dnf module enable nodejs:18 -y &>>log_file
echo $?

head "install the nodejs"
dnf install nodejs -y &>>log_file
echo $?

head "configure the backend service"
cp backend.service /etc/systemd/system/backend.service &>>log_file
echo $?

head "adding user"
useradd expense &>>log_file
echo $?

app_pre "/app"

head "install npm"
npm install &>>log_file
echo $?

head "enable and start the backend"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl start backend &>>log_file
echo $?

head "install mysql"
dnf install mysql -y &>>log_file
echo $?

head "loading schema"
mysql -h mysql.madhanmohanreddy.tech -uroot -p${mysql_password} < /app/schema/backend.sql &>>log_file
echo $?