#!/bin/bash

source ./env.sh
docker-compose -f ${DC_FILE} exec kafka \
    /kafka/bin/kafka-consumer-groups.sh \
    --bootstrap-server kafka:9092 \
    --delete --group ${CONNECTOR_NAME_TARGET_has_connect}


# docker-compose -f ${DC_FILE} exec kafka \
#     /kafka/bin/kafka-consumer-groups.sh \
#     --bootstrap-server kafka:9092 \
#     --all-groups --delete

# echo

