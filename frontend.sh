source common.sh
component=frontend

head "install nginx"
dnf install nginx -y &>>$log_file
echo $?
head "copy the expense configuration file"
cp expense.conf /etc/nginx/default.d/expense.conf  &>>$log_file
echo $?


app_prereq "/usr/share/nginx/html"

head "enable and start nginx"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
echo $?