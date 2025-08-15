#!/bin/bash

source ./env.sh

./configuring-source.sh

echo

./configuring-target.sh

echo

echo "---------------------------------------------"

echo "We sychronized the ${bold}${SOURCE_TYPE}${reset} source with the ${bold}${TARGET_TYPE}${reset} target,"
echo "with source ${bold}${SOURCE_TYPE}${reset} table include list: inventory.customers, inventory.products."
echo "and target ${bold}${TARGET_TYPE}${reset} table will be created with the same name as the source table."

echo "---------------------------------------------"
