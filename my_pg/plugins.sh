#!/bin/bash

source ./env.sh

echo "---------------------------------------------"
echo "List of all plugins available in the Kafka Connect"
echo "---------------------------------------------"

output=$(curl -sS -X GET http://localhost:8083/connector-plugins/ \
    -H "Accept:application/json" \
    -H "Content-Type:application/json" )

echo $output | jq .

echo

