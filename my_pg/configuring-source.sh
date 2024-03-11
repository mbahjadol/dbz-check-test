#!/bin/bash

source ./env.sh

echo "---------------------------------------------"
echo "Configuring the source connector for the ${SOURCE_TYPE} source:"
echo "---------------------------------------------"

# Use jq to modify the JSON file and save the result to a variable
transforms_route_replacement=$TOPIC_PREFIX"_\$3"

# this will create a comma separated list of tables with the source database name
table_include_list=$(echo "$SYNC_TABLE_LIST" | awk -v source="$SYNC_DATABASE_SOURCE" -F ',' '{for(i=1;i<=NF;i++) printf "%s.%s%s", source, $i, (i==NF?"":", ")}')

schema_history_topic="_schema_changes."$SYNC_DATABASE_SOURCE

source_json=$(jq \
    --arg name "$CONNECTOR_NAME_SOURCE" \
    --arg db_host "$SOURCE_HOST" \
    --arg db_port "$SOURCE_PORT" \
    --arg db_user "$SOURCE_DB_ROOT_USER" \
    --arg db_password "$SOURCE_ROOT_PASSWORD" \
    --arg db_server_id "$SOURCE_DATABASE_SERVER_ID" \
    --arg topic_prefix "$TOPIC_PREFIX" \
    --arg transforms_route_replacement "$transforms_route_replacement" \
    --arg table_include_list "$table_include_list" \
    --arg schema_history_topic "$schema_history_topic" \
    '
        .name=$name |
        .config["database.hostname"]=$db_host |
        .config["database.port"]=$db_port |
        .config["database.user"]=$db_user |
        .config["database.password"]=$db_password |
        .config["database.server.id"]=$db_server_id |
        .config["topic.prefix"]=$topic_prefix |
        .config["transforms.route.replacement"]=$transforms_route_replacement |
        .config["table.include.list"]=$table_include_list |
        .config["schema.history.internal.kafka.topic"]=$schema_history_topic
    ' \
    source.json)

output=$(curl -sS -X POST http://localhost:8083/connectors/ \
    -H "Accept:application/json" \
    -H "Content-Type:application/json" \
    -d "$source_json")

echo $output | jq .

echo

