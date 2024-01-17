log_file=/tmp/expense.log

head(){
  echo -e "\e[36m$1\e[0m"
}

head "install nginx"
dnf install nginx -y &>>$log_file
echo $?
head "copy the expense configuration file"
cp expense.conf /etc/nginx/default.d/expense.conf  &>>$log_file
echo $?

head "remove the default content"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?
head "download the expense content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
echo $?
head "change the directory"
cd /usr/share/nginx/html &>>$log_file
echo $?
head "extract the expense content"
unzip /tmp/frontend.zip &>>$log_file
echo $?
head "enable and start nginx"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
echo $?