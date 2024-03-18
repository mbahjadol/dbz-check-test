#!/bin/bash

source ./env.sh

echo "starting the containers."
docker compose -f ${DC_FILE} up -d --build --force-recreate

# Include readines-containers.sh
source ./readiness-containers.sh

echo "---------------------------------------------"
echo "Checking for all containers are fully running."
echo "---------------------------------------------"

check_oracle_container "$SOURCE_NAME"
check_oracle_container "$TARGET_NAME"
check_zookeeper_container
check_kafka_container
check_debezium_connect_container
check_kafka_ui_container

echo "All containers are fully running!"
press_enter

./configure.sh
press_enter

./testing.sh
echo

echo "All tests are done!"

echo "---------------------------------------------"

echo "You can stop all the containers by running the following command:"
echo "${bold}./stop.sh${reset}"

echo "---------------------------------------------"
