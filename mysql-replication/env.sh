#!/bin/bash

# Debezium Version
export DEBEZIUM_VERSION="2.5"

# Docker Composer File
export DC_FILE="docker-compose.yaml"

# Kafka Storage Configuration
export CONFIG_STORAGE_TOPIC="_storage_configs"
export OFFSET_STORAGE_TOPIC="_storage_offsets"
export STATUS_STORAGE_TOPIC="_storage_statuses"

# Source Database Configuration
export SOURCE_NAME="mysql-master"
export SOURCE_TYPE="mysql"
export SOURCE_HOST=${SOURCE_NAME}
export SOURCE_PORT="3306"
export SOURCE_DB_ROOT_USER="root"
export SOURCE_ROOT_PASSWORD="debezium"
export SOURCE_USER="mysqluser"
export SOURCE_PASSWORD="mysqlpw"
export SOURCE_DATABASE_SERVER_ID="12345"

# Target Database Configuration
export TARGET_NAME="mysql-replica"
export TARGET_TYPE="mysql"
export TARGET_HOST=${TARGET_NAME}
export TARGET_PORT="3306"
export TARGET_DB_ROOT_USER="root"
export TARGET_ROOT_PASSWORD="debezium"
export TARGET_USER="mysqluser"
export TARGET_PASSWORD="mysqlpw"
export TARGET_DATABASE_SERVER_ID="12346"

# Connector Configuration
export TOPIC_PREFIX="mypg"
export CONNECTOR_NAME_SOURCE=$TOPIC_PREFIX"_source"
export CONNECTOR_NAME_TARGET=$TOPIC_PREFIX"_target"
export CONNECTOR_NAME_TARGET_has_connect="connect-"$TOPIC_PREFIX"_target"

export SYNC_DATABASE_SOURCE="inventory"
export SYNC_SCHEMA_SOURCE=""
export SYNC_DATABASE_TARGET="postgres"
export SYNC_SCHEMA_TARGET="inventory"
export SYNC_TABLE_LIST="customers,products" # WARNING: comma separated list of tables, value without spaces !



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
