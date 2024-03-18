#!/bin/bash

# Debezium Version
export DEBEZIUM_VERSION="1.7"
export PROJECT_PATH=$(pwd -P)

# Docker Composer File
# export DC_FILE="docker-compose.local-jadol.yaml"
export DC_FILE="docker-compose.yaml"

# Kafka Storage Configuration
export CONFIG_STORAGE_TOPIC="_storage_configs"
export OFFSET_STORAGE_TOPIC="_storage_offsets"
export STATUS_STORAGE_TOPIC="_storage_statuses"

# Source Database Configuration
export SOURCE_NAME="source-db"
export SOURCE_TYPE="oracle"
export SOURCE_HOST=${SOURCE_NAME}
export SOURCE_PORT="1521"
export SOURCE_PORT_INTERNAL="1521"
export SOURCE_SYS_USER="sys"
export SOURCE_SYSTEM_USER="system"
export SOURCE_PDBADMIN_USER="pdbadmin"
export SOURCE_ADMIN_PASSWORD="oracle"
export SOURCE_USER="sys"
export SOURCE_PASSWORD="oracle"

# Target Database Configuration
export TARGET_NAME="target-db"
export TARGET_TYPE="oracle"
export TARGET_HOST=${TARGET_NAME}
export TARGET_PORT="3402"
export TARGET_PORT_INTERNAL="1521"
export TARGET_SYS_USER="sys"
export TARGET_SYSTEM_USER="system"
export TARGET_PDBADMIN_USER="pdbadmin"
export TARGET_ADMIN_PASSWORD="oracle"
export TARGET_USER="sys"
export TARGET_PASSWORD="oracle"

# Connector Configuration
export TOPIC_PREFIX="oramy"
export CONNECTOR_NAME_SOURCE=$TOPIC_PREFIX"_source"
export CONNECTOR_NAME_TARGET=$TOPIC_PREFIX"_target"
export CONNECTOR_NAME_TARGET_has_connect="connect-"$TOPIC_PREFIX"_target"

export SYNC_DATABASE_SOURCE="XE"
export SYNC_SCHEMA_SOURCE=""
export SYNC_DATABASE_TARGET="XE"
export SYNC_SCHEMA_TARGET=""
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
