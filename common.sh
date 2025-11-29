
systemd_setup(){
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
}

app_prereq() {
    id roboshop
    if [ $? -eq 1 ]; then
        useradd roboshop
    fi

    rm -r /app
    mkdir /app

    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip
    cd /app
    unzip /tmp/${component}.zip
}

nodejs_setup(){
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y

  dnf install nodejs -y

  cp ${component}.service /etc/systemd/system/${component}.service

  app_prereq

  cd /app
  npm install

  systemd_setup

}

python_setup() {
  dnf install python3 gcc python3-devel -y
  app_prereq
  cd /app
  pip3 install -r requirements.txt
  systemd_setup
}

java_setup(){
  dnf install maven -y
  app_prereq
  cd /app
  mvn clean package
  mv target/${component}-1.0.jar ${component}.jar
  systemd_setup
}