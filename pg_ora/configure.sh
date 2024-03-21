#!/bin/bash

source ./env.sh

./configuring-source.sh

echo

./configuring-target.sh

echo

echo "---------------------------------------------"

echo "We sychronized the source with the target,"
echo "and target table will be created with the same name as the source table."

echo "---------------------------------------------"
