#!/bin/bash

source ./env.sh

# Initialize database and insert test data
cat debezium-sqlserver-init/inventory.sql | \
    docker exec -i $SOURCE_NAME bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD'

echo "Database and test data are initialized."