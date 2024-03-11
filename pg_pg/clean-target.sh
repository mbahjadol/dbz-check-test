#!/bin/bash

source ./env.sh

docker compose -f ${DC_FILE} exec -u ${TARGET_USER} ${TARGET_NAME} \
    psql -c "drop schema inventory cascade; create schema inventory;"

