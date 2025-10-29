#!/bin/bash

source ./env.sh

# Initialize database and insert test data
cat debezium-sqlserver-init/inventory.sql | \
    docker exec -i $SOURCE_NAME bash -c "$SQLCMD -U '$SA_USER' -P '$SA_PASSWORD'"

echo "Database and test data are initialized."