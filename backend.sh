echo disable the nodejs version
dnf module disable nodejs -y

echo enable the nodejs 18 version
dnf module enable nodejs:18 -y

echo install the nodejs
dnf install nodejs -y

echo configure the backend service
cp backend.service /etc/systemd/system/backend.service

echo adding the user
useradd expense

echo removing the default content
rm -rf /app

echo creating the directory
mkdir /app

echo download the application content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app

echo extracting application content
unzip /tmp/backend.zip

echo downloading the application dependencies
npm install

echo relaoding the systemd and start the backend srevice
systemctl daemon-reload
systemctl enable backend
systemctl start backend

echo install mysql client
dnf install mysql -y

echo load schema
mysql -h mysql.madhanmohanreddy.tech -uroot -pExpenseApp@1 < /app/schema/backend.sql