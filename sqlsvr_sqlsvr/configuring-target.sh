#!/bin/bash

source ./env.sh

echo "---------------------------------------------"
echo "Configuring the target connector for the ${TARGET_TYPE} target:"
echo "---------------------------------------------"

# Use jq to modify the JSON file and save the result to a variable

connection_url="jdbc:$TARGET_TYPE://$TARGET_HOST:$TARGET_PORT;databaseName=$SYNC_DATABASE_TARGET;encrypt=false"
transforms_remove_prefix=$TOPIC_PREFIX"_(.*)"
topics_target=$(echo "$SYNC_TABLE_LIST" | awk -v prefix="$TOPIC_PREFIX" -F ',' '{for(i=1;i<=NF;i++) printf "%s_%s%s", prefix, $i, (i==NF?"":", ")}')

target_json=$(jq \
    --arg name "$CONNECTOR_NAME_TARGET" \
    --arg connection_url "$connection_url" \
    --arg db_user "$TARGET_USER" \
    --arg db_password "$TARGET_PASSWORD" \
    --arg transforms_remove_prefix_regex "$transforms_remove_prefix" \
    --arg topics "$topics_target" \
    --arg topic_prefix "$TOPIC_PREFIX" \
    '
        .name=$name |
        .config["topics"]=$topics |
        .config["topic.prefix"]=$topic_prefix |
        .config["connection.url"]=$connection_url |
        .config["connection.username"]=$db_user |
        .config["connection.password"]=$db_password |
        .config["transforms.removePrefix.regex"]=$transforms_remove_prefix_regex
    ' \
    target.json)

output=$(curl -sS -X POST http://localhost:8083/connectors/ \
    -H "Accept:application/json" \
    -H "Content-Type:application/json" \
    -d "$target_json")

echo $output | jq .

echo

# output=$(curl -sS -X POST http://localhost:8083/connectors/ \
#     -H "Accept:application/json" \
#     -H "Content-Type:application/json" \
#     -d @./target-manual.json)

# echo $output | jq .
