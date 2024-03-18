#!/bin/bash

source ./env.sh

echo "---------------------------------------------"
echo "Building all the containers."
echo "---------------------------------------------"

docker compose up --build --no-start

echo "---------------------------------------------"