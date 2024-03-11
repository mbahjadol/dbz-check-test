#!/bin/bash

source ./env.sh

echo "---------------------------------------------"
echo "-- Deconfigure all setup --"

echo "-- Removing all connectors --"
./remove-connectors.sh

echo "-- Removing all consumer groups --"
./remove-kafka-consumer-groups.sh

echo "-- Removing all kafka topics --"
./remove-kafka-topics.sh

