#!/bin/bash

source ./env.sh

docker compose -f ${DC_FILE} down

