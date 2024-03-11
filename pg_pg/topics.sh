#!/bin/bash

source ./env.sh

echo "Listing all Topics in kafka:"
docker compose -f ${DC_FILE} exec kafka \
/kafka/bin/kafka-topics.sh \
--bootstrap-server kafka:9092 \
--list

echo "-----------------------------"

echo "Listing all Consumer Groups in kafka:"
docker-compose -f ${DC_FILE} exec kafka \
/kafka/bin/kafka-consumer-groups.sh \
--bootstrap-server kafka:9092 \
--list

