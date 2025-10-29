#!/bin/bash

# Get the list of all connectors
connectors=$(curl -s http://localhost:8083/connectors | jq -r '.[]')

# Loop over the connectors and delete each one
for connector in $connectors; do
    echo "Removing connector: $connector"
    curl -X DELETE http://localhost:8083/connectors/$connector
done

