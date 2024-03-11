#!/bin/bash

source ./env.sh

docker-compose -f ${DC_FILE} exec kafka \
    /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic ${TOPIC_PREFIX}_customers
