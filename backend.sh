log_file=/tmp/expense.log

echo "disable the nodejs"
dnf module disable nodejs -y &>>log_file

echo "enable the nodejs"
dnf module enable nodejs:18 -y &>>log_file

echo "install the nodejs"
dnf install nodejs -y &>>log_file

echo "configure the backend service"
cp backend.service /etc/systemd/system/backend.service &>>log_file

echo "adding user"
useradd expense &>>log_file

echo "removing the default content"
rm -rf /app &>>log_file

echo "create directory"
mkdir /app &>>log_file

echo "download the application content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file

echo "change directory"
cd /app &>>log_file

echo " extract the application content"
unzip /tmp/backend.zip &>>log_file

echo "install npm"
npm install &>>log_file

echo "enable and start the backend"
systemctl daemon-reload &>>log_file

systemctl enable backend &>>log_file

systemctl start backend &>>log_file

echo "install mysql"
dnf install mysql -y &>>log_file

echo "loading schema"
mysql -h mysql.madhanmohanreddy.tech -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file