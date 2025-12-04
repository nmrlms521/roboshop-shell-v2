source common.sh
component=shipping
java_setup

dnf install mysql -y
mysql -h mysql-dev.smks.online -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h mysql-dev.smks.online -uroot -pRoboShop@1 < /app/db/app-user.sql
mysql -h mysql-dev.smks.online -uroot -pRoboShop@1 < /app/db/master-data.sql
