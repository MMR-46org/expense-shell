$1
log_file=/tmp/expense.log
echo -e "\e[36mdisable the nodejs\e[0m"
dnf module disable nodejs -y &>>$log_file
echo -e "\e[36menbale the nodejs\e[0m"
dnf module enable nodejs:18 -y &>>$log_file

echo -e "\e[36minstall the nodejs\e[0m"
dnf install nodejs -y &>>$log_file

echo -e "\e[36mconfigure the backend service\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file

echo -e "\e[36madding the user\e[0m"
useradd expense &>>$log_file

echo -e "\e[36mremoving the default content\e[0m"
rm -rf /app &>>$log_file

echo -e "\e[36mcreating the directory\e[0m"
mkdir /app &>>$log_file

echo -e "\e[36mdownload the backend content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app &>>$log_file

echo -e "\e[36mextract the backend content\e[0m"
unzip /tmp/backend.zip &>>$log_file

echo -e "\e[36minstall the required packages\e[0m"
npm install &>>$log_file

echo -e "\e[36mreload the systemd and start the service"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file

echo -e "\e[36m install the mysql client\e[0m"
dnf install mysql -y &>>$log_file

echo -e "\e[36m reload the schema\e[0m"
mysql -h mysql.madhanmohanreddy.tech -uroot -p$1 < /app/schema/backend.sql &>>$log_file