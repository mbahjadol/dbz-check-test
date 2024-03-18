#!/bin/bash

source ./env.sh


echo "Removing topic: $1"
docker compose -f ${DC_FILE} exec kafka \
    /kafka/bin/kafka-topics.sh \
    --bootstrap-server kafka:9092 \
    --delete --topic "$1"



