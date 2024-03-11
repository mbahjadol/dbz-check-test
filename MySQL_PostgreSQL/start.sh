#!/bin/bash

export DEBEZIUM_VERSION="2.5"

docker compose -f docker-compose-jdbc.yaml up -d

