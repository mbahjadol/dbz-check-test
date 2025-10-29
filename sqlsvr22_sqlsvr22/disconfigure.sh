#!/bin/bash

set -e

source ./env.sh

echo "---------------------------------------------"
echo "-- Deconfigure all setup --"

echo "-- Removing all connectors --"
./remove-connectors.sh || true

echo "-- Removing all consumer groups --"
./remove-kafka-consumer-groups.sh || true

echo "-- Removing all kafka topics --"
./remove-kafka-topics.sh || true

