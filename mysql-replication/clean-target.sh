#!/bin/bash

source ./env.sh

docker compose -f ${DC_FILE} exec -e MYSQL_PWD=${TARGET_PASSWORD} ${TARGET_NAME} \
    mysql -u${TARGET_USER} -e \
    "DROP DATABASE IF EXISTS database_name; CREATE DATABASE inventory;"

