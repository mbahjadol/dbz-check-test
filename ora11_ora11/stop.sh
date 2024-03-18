#!/bin/bash

source ./env.sh

echo "Stopping the containers."
docker compose -f ${DC_FILE} down

