echo -e "\e[36mdisable the nodejs version\e[0m"
dnf module disable nodejs -y >out

echo -e "\e[36menable the nodejs 18 version\e[0m"
dnf module enable nodejs:18 -y >out

echo -e "\e[36minstall the nodejs\e[0m"
dnf install nodejs -y >out

echo -e "\e[36mconfigure the backend service\e[0m"
cp backend.service /etc/systemd/system/backend.service >out

echo -e "\e[36madding the user\e[0m"
useradd expense >out

echo -e "\e[36mremoving the default content\e[0m"
rm -rf /app >out

echo -e "\e[36mcreating the directory\e[0m"
mkdir /app >out

echo -e "\e[36mdownload the application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >out
cd /app >out

echo -e "\e[36mextracting application content\e[0m"
unzip /tmp/backend.zip >out

echo -e "\e[36mdownloading the application dependencies\e[0m"
npm install >out

echo -e "\e[36mrelaoding the systemd and start the backend srevice\e[0m"
systemctl daemon-reload >out
systemctl enable backend >out
systemctl start backend >out

echo -e "\e[36minstall mysql client\e[0m"
dnf install mysql -y >out

echo -e "\e[36mload schema\e[0m"
mysql -h mysql.madhanmohanreddy.tech -uroot -pExpenseApp@1 < /app/schema/backend.sql >out