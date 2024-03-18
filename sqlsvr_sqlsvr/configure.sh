#!/bin/bash

source ./env.sh

./configuring-source.sh

echo

./configuring-target.sh

echo

echo "---------------------------------------------"

echo "We sychronized the PostgreSQL source with the MySQL target,"
echo "with source PostgreSQL table include list: inventory.customers, inventory.products."
echo "and target MySQL table will be created with the same name as the source table."

echo "---------------------------------------------"
