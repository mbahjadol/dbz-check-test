#!/bin/bash

source ./env.sh

echo "---------------------------------------------"
echo "Configuring the source connector for the ${SOURCE_TYPE} source:"
echo "---------------------------------------------"

# Use jq to modify the JSON file and save the result to a variable
transforms_route_replacement=$TOPIC_PREFIX"_\$4"

# this will create a comma separated list of tables with the source database name
table_include_list=$(echo "$SYNC_TABLE_LIST" | awk -v source="$SYNC_SCHEMA_SOURCE" -F ',' '{for(i=1;i<=NF;i++) printf "%s.%s%s", source, $i, (i==NF?"":", ")}')

source_json=$(jq \
    --arg name "$CONNECTOR_NAME_SOURCE" \
    --arg db_host "$SOURCE_HOST" \
    --arg db_port "$SOURCE_PORT" \
    --arg db_user "$SOURCE_USER" \
    --arg db_password "$SOURCE_PASSWORD" \
    --arg topic_prefix "$TOPIC_PREFIX" \
    --arg transforms_route_replacement "$transforms_route_replacement" \
    --arg table_include_list "$table_include_list" \
    --arg sync_database_source "$SYNC_DATABASE_SOURCE" \
    '
        .name=$name |
        .config["database.hostname"]=$db_host |
        .config["database.port"]=$db_port |
        .config["database.user"]=$db_user |
        .config["database.password"]=$db_password |
        .config["topic.prefix"]=$topic_prefix |
        .config["transforms.route.replacement"]=$transforms_route_replacement |
        .config["table.include.list"]=$table_include_list |
        .config["database.names"]=$sync_database_source
    ' \
    source.json)

output=$(curl -sS -X POST http://localhost:8083/connectors/ \
    -H "Accept:application/json" \
    -H "Content-Type:application/json" \
    -d "$source_json")

echo $output | jq .

echo

