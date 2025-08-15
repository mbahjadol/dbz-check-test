#!/bin/bash

# Debezium Version
export DEBEZIUM_VERSION="2.5"

# Docker Composer File
export DC_FILE="compose.yaml"

# Kafka Storage Configuration
export CONFIG_STORAGE_TOPIC="_storage_configs"
export OFFSET_STORAGE_TOPIC="_storage_offsets"
export STATUS_STORAGE_TOPIC="_storage_statuses"

# Source Database Configuration
export SOURCE_NAME="source-db"
export SOURCE_TYPE="sqlsvr"
export SOURCE_HOST=${SOURCE_NAME}
export SOURCE_PORT="1433"
export SOURCE_USER="sa"
export SOURCE_PASSWORD="Password!"

# Target Database Configuration
export TARGET_NAME="target-db"
export TARGET_TYPE="mysql"
export TARGET_HOST=${TARGET_NAME}
export TARGET_PORT="3306"
export TARGET_DB_ROOT_USER="root"
export TARGET_ROOT_PASSWORD="debezium"
export TARGET_USER="mysqluser"
export TARGET_PASSWORD="mysqlpw"

# Connector Configuration
export TOPIC_PREFIX="sqlsvrmy"
export CONNECTOR_NAME_SOURCE=$TOPIC_PREFIX"_source"
export CONNECTOR_NAME_TARGET=$TOPIC_PREFIX"_target"
export CONNECTOR_NAME_TARGET_has_connect="connect-"$TOPIC_PREFIX"_target"

export SYNC_DATABASE_SOURCE="inventory"
export SYNC_SCHEMA_SOURCE="dbo"
export SYNC_DATABASE_TARGET="inventory"
export SYNC_SCHEMA_TARGET=""
export SYNC_TABLE_LIST="customers,products" # WARNING: comma separated list of tables, value without spaces !

# SQL SERVER Command Path and include the -C and -N options for secure connections
export SQLCMD="/opt/mssql-tools18/bin/sqlcmd -C -N"


# Utilities Function and Text Formatting
function press_enter() {
    read -n 1 -s -r -p "# Press Enter to continue... \$ "
    echo
}

# Define variables for bold and coloring
bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
reset=$(tput sgr0)
black=$(tput setaf 0)
magenta=$(tput setaf 5)
white=$(tput setaf 7)

# # Example of echo formatting
# echo "${bold}This is bold text${reset}"
# echo "${red}This is red text${reset}"
# echo "${green}This is green text${reset}"
# echo "${yellow}This is yellow text${reset}"
# echo "${blue}This is blue text${reset}"
# echo "${black}This is black text${reset}"
# echo "${magenta}This is magenta text${reset}"
# echo "${white}This is white text${reset}"
