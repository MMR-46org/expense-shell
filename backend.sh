mysql_password=$1
log_file=/tmp/expense.log

head() {
  echo -e "\e[36m$1\e[0m"
}

head "disable the nodejs"
dnf module disable nodejs -y &>>$log_file
echo $?
head "enbale the nodejs"
dnf module enable nodejs:18 -y &>>$log_file
echo $?
head "install the nodejs"
dnf install nodejs -y &>>$log_file
echo $?
head "configure the backend service"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?
head "adding the user"
useradd expense &>>$log_file
echo $?
head "removing the default content"
rm -rf /app &>>$log_file
echo $?
head "creating the directory"
mkdir /app &>>$log_file
echo $?
head "download the backend content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app &>>$log_file
echo $?
head "extract the backend content"
unzip /tmp/backend.zip &>>$log_file
echo $?
head "install the required packages"
npm install &>>$log_file
echo $?
head "reload the systemd and start the service"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
echo $?
head " install the mysql client"
dnf install mysql -y &>>$log_file
echo $?
head " reload the schema"
mysql -h mysql.madhanmohanreddy.tech -uroot -p${mysql_password} < /app/schema/backend.sql &>>$log_file
echo $?