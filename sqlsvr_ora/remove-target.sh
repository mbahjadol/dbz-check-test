#!/bin/bash

source ./env.sh

 ./remove-connector.sh ${CONNECTOR_NAME_TARGET} &&  ./remove-kafka-consumer-groups.sh connect-${CONNECTOR_NAME_TARGET}