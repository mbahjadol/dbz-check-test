#!/bin/bash

source ./env.sh

docker-compose -f ${DC_FILE} exec kafka \
/kafka/bin/kafka-consumer-groups.sh \
--bootstrap-server kafka:9092 \
--describe --group ${CONNECTOR_NAME_TARGET_has_connect}