echo -e "\e[36mdisable the nodejs version\e[0m"
dnf module disable nodejs -y

echo -e "\e[36menable the nodejs 18 version\e[0m"
dnf module enable nodejs:18 -y

echo -e "\e[36minstall the nodejs\e[0m"
dnf install nodejs -y

echo -e "\e[36mconfigure the backend service\e[0m"
cp backend.service /etc/systemd/system/backend.service

echo -e "\e[36madding the user\e[0m"
useradd expense

echo -e "\e[36mremoving the default content\e[0m"
rm -rf /app

echo -e "\e[36mcreating the directory\e[0m"
mkdir /app

echo -e "\e[36mdownload the application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app

echo -e "\e[36mextracting application content\e[0m"
unzip /tmp/backend.zip

echo -e "\e[36mdownloading the application dependencies\e[0m"
npm install

echo -e "\e[36mrelaoding the systemd and start the backend srevice\e[0m"
systemctl daemon-reload
systemctl enable backend
systemctl start backend

echo -e "\e[36minstall mysql client\e[0m"
dnf install mysql -y

echo -e "\e[36mload schema\e[0m"
mysql -h mysql.madhanmohanreddy.tech -uroot -pExpenseApp@1 < /app/schema/backend.sql