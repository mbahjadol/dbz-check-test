#!/bin/bash

source ./env.sh

echo "---------------------------------------------"
echo "Configuring the target connector for the ${TARGET_TYPE} target:"
echo "---------------------------------------------"

# Use jq to modify the JSON file and save the result to a variable

output=$(curl -sS -X POST http://localhost:8083/connectors/ \
    -H "Accept:application/json" \
    -H "Content-Type:application/json" \
    -d @./target-manual.json)

echo $output | jq .
