#!/bin/bash

source ./env.sh

# Initialize database and insert test data
cat debezium-sqlserver-init/inventory.sql | \
    docker exec -i $SOURCE_NAME bash -c "$SQLCMD -U '$SOURCE_USER' -P '$SOURCE_PASSWORD'"

echo "Database and test data are initialized."