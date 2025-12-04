
source common.sh

cp mongo.repo /etc/yum.repos.d/mongo.repo
# shellcheck disable=SC2034
component=catalogue
nodejs_setup

dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.smks.online </app/db/master-data.js
