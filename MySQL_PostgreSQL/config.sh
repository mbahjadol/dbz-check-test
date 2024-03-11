#!/bin/bash
output=$(curl -sS -X POST http://localhost:8083/connectors/ \
    -H "Accept:application/json" \
    -H "Content-Type:application/json" \
-d @./source.json) | echo $output | jq .


output=$(curl -sS -X POST http://localhost:8083/connectors/ \
    -H "Accept:application/json" \
    -H "Content-Type:application/json" \
-d @./jdbc-sink.json) | echo $output | jq .

