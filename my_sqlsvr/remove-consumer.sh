#!/bin/bash

source ./env.sh

echo "Removing consumer group: $1"
docker-compose -f ${DC_FILE} exec kafka \
    /kafka/bin/kafka-consumer-groups.sh \
    --bootstrap-server kafka:9092 \
    --delete --group $1


# docker-compose -f ${DC_FILE} exec kafka \
#     /kafka/bin/kafka-consumer-groups.sh \
#     --bootstrap-server kafka:9092 \
#     --all-groups --delete

# echo

