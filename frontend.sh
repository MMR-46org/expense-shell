source common.sh
component=frontend

head "install the nginx"
dnf install nginx -y &>>log_file
stat $?

head "configure the expense.conf"
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file
stat $?

app_pre "/usr/share/nginx/html"

head "enable the nginx server"
systemctl enable nginx &>>log_file
stat $?

head "restart the nginx server"
systemctl restart nginx &>>log_file
stat $?