#!/bin/bash

source ./env.sh

# setup initiate files to be mount in the container
cat mysql-init/inventory.sql.templ | sed -e 's/XXX_USER_XXX/mysqluser/g' | sed -e 's/XXX_PASSWORD_XXX/mysqlpw/g' > mysql-init/inventory.sql


echo "starting the containers."
docker compose -f ${DC_FILE} up -d --build --force-recreate
#docker compose -f ${DC_FILE} up -d

# Include readiness-containers.sh
source ./readiness-containers.sh

echo "---------------------------------------------"
echo "Checking for all containers are fully running."
echo "---------------------------------------------"

check_postgresql_container "$SOURCE_NAME"
check_oracle_container "$TARGET_NAME"
check_zookeeper_container
check_kafka_container
check_debezium_connect_container
check_kafka_ui_container

echo "All containers are fully running!"
press_enter

./initialize-target.sh

./configure.sh
press_enter

# ./testing.sh
# echo

# echo "All tests are done!"

# echo "---------------------------------------------"

# echo "You can stop all the containers by running the following command:"
# echo "${bold}./stop.sh${reset}"

# echo "---------------------------------------------"
