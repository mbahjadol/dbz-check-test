#!/bin/bash

source ./env.sh


# # # create user and password in database
# docker compose -f ${DC_FILE} exec -T ${TARGET_NAME} /bin/bash -c "createAppUser ${TARGET_USER} ${TARGET_PASSWORD} ${SYNC_DATABASE_TARGET}"


# # Initialize the source database
# data=$(cat ora-inventory.sql)
# docker exec -i ${TARGET_NAME} sqlplus -s ${TARGET_USER}/${TARGET_PASSWORD}@${TARGET_NAME}:${TARGET_PORT}/${SYNC_DATABASE_TARGET}<<EOF
# ${data}
# EOF


echo "Database and test data are initialized."