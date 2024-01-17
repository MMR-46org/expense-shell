log_file=/tmp/expense.log

head() {
  echo -e "\e[36m$1\e[0m"
}

app_prereq() {
  DIR=$1

  head "removing the default content"
  rm -rf $1 &>>$log_file
  echo $?

  head "creating the directory"
  mkdir $1 &>>$log_file
  echo $?

  head "download the backend content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
  echo $?

  cd $1

  head "extract the backend content"
  unzip /tmp/${component}.zip &>>$log_file
  echo $?
}