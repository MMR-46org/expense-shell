log_file=/tmp/expense.log

head (){
  echo -e "\e[36m$1\e[0m"
}

app_pre(){
  dir=$1

  head "removing the default content"
  rm -rf $1 &>>log_file
  stat $?

  head "create directory"
  mkdir $1 &>>log_file
  stat $?

  head "download the application content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>log_file
  stat $?

  cd $1

  head " extract the application content"
  unzip /tmp/${component}.zip &>>log_file
  stat $?


}

stat () {
  if [ $? -eq 0 ];then
    echo SUCCESS
  else
    echo FAILURE
    exit 1
  fi
}