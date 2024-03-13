#!/bin/bash

source ./env.sh

cat ./debezium-sqlserver-init/inventory-as-target.sql | docker compose -f ${DC_FILE} exec -T -i ${TARGET_NAME} bash -c \
    "/opt/mssql-tools/bin/sqlcmd -U $TARGET_USER -P $TARGET_PASSWORD "
