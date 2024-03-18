#!/bin/bash

source ./env.sh


# # create user and password in database
docker compose -f ${DC_FILE} exec -T ${SOURCE_NAME} /bin/bash -c "createAppUser ${SOURCE_USER} ${SOURCE_PASSWORD} ${SYNC_DATABASE_SOURCE}"


# Initialize the source database
data=$(cat ora-inventory.sql)
docker exec -i ${SOURCE_NAME} sqlplus -s ${SOURCE_USER}/${SOURCE_PASSWORD}@${SOURCE_NAME}:${SOURCE_PORT}/${SYNC_DATABASE_SOURCE}<<EOF
${data}
EOF


echo "Database and test data are initialized."