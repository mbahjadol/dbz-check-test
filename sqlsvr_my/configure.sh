#!/bin/bash

source ./env.sh

./configuring-source.sh

echo

./configuring-target.sh

echo

echo "---------------------------------------------"

echo "We sychronized the ${SOURCE_TYPE} source with the ${TARGET_TYPE} target,"
echo "with source ${SOURCE_TYPE} table include list: inventory.customers, inventory.products."
echo "and target ${TARGET_TYPE} table will be created with the same name as the source table."

echo "---------------------------------------------"
