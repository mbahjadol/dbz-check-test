#!/bin/bash

connectors=$(curl -s -XGET http://localhost:8083/connectors | jq '.[]')

if [[ -n "$connectors" ]]; then
    echo "Listing all connectors registered in kafka-connect ($(echo "$connectors" | wc -l)) :"
    echo "$connectors"
else
    echo "No connectors found in kafka-connect."
fi

