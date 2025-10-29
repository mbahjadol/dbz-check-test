#!/bin/bash

source ./env.sh

function check_sqlserver_container() {
    container_name=$1
    SA_USER=$2
    SA_PWD=$3
    echo -n "Waiting '$container_name' ."
    while true; do
        status=$(docker inspect --format "{{.State.Status}}" $container_name)

        if [ "$status" == "running" ]; then
            # SQL Server takes a while to start up, check if it's ready to accept connections
            ready=$(docker exec -e SA_PASSWORD=$SA_PWD $container_name $SQLCMD -S localhost -U $SA_USER -P $SA_PWD -Q "SELECT 1" -C -N 2>/dev/null)

            if [[ "$ready" == *"1 rows affected"* ]]; then
                echo -e "... ${green}READY${reset}"
                break
            fi
        fi
        # Wait before checking again
        echo -n "."
        sleep 1
    done
}

function check_postgresql_container() {
    container_name=$1
    PGSQL_USER=$2
    PGSQL_PWD=$3
    echo -n "Waiting '$container_name' ."
    while true; do
        status=$(docker inspect --format "{{.State.Status}}" $container_name)

        if [ "$status" == "running" ]; then
            # PostgreSQL takes a while to start up, check if it's ready to accept connections
            ready=$(docker exec $container_name /bin/bash -c "pg_isready -h localhost -p 5432 -U ${PGSQL_USER}")

            if [ "$ready" == "localhost:5432 - accepting connections" ]; then
                echo -e "... ${green}READY${reset}"
                break
            fi
        fi
        # Wait before checking again
        echo -n "."
        sleep 1
    done
}

function check_mysql_container() {
    container_name=$1
    MYSQL_USER=$2
    MYSQL_PWD=$3
    echo -n "Waiting '$container_name' ."
    while true; do
        status=$(docker inspect --format "{{.State.Status}}" $container_name)

        if [ "$status" == "running" ]; then
            # MySQL takes a while to start up, check if it's ready to accept connections
            ready=$(docker exec -e MYSQL_PWD=$MYSQL_PWD $container_name mysqladmin -u${MYSQL_USER} ping --silent)

            if [ "$ready" == "mysqld is alive" ]; then
                echo -e "... ${green}READY${reset}"
                break
            fi
        fi
        # Wait before checking again
        echo -n "."
        sleep 1
    done
}

function check_zookeeper_container() {
    container_name="zookeeper"
    echo -n "Waiting '$container_name' ."
    while true; do
        status=$(docker inspect --format "{{.State.Status}}" $container_name)

        if [ "$status" == "running" ]; then
            # ZooKeeper takes a while to start up, check if it's ready to accept connections
            ready=$(docker exec $container_name /bin/bash -c "curl -s -o /dev/null -w '%{http_code}' http://localhost:2181")

            if [ "$ready" != "" ]; then
                echo -e "... ${green}READY${reset}"
                break
            fi
        fi
        # Wait before checking again
        echo -n "."
        sleep 1
    done
}

function check_kafka_container() {
    container_name="kafka"
    echo -n "Waiting '$container_name' ."
    while true; do
        status=$(docker inspect --format "{{.State.Status}}" $container_name)

        if [ "$status" == "running" ]; then
            # Kafka takes a while to start up, check if it's ready to accept connections
            ready=$(docker exec $container_name /bin/bash -c "/kafka/bin/kafka-topics.sh --list --bootstrap-server kafka:9092" 2>/dev/null)

            if [[ "$ready" != "" || "$ready" != *"could not be established"* && "$ready" != *"Timed out waiting for a node assignment"* ]]; then
                echo -e "... ${green}READY${reset}"
                break
            fi
        fi
        # Wait before checking again
        echo -n "."
        sleep 1
    done
}

function check_debezium_connect_container() {
    container_name="connect"
    echo -n "Waiting '$container_name' ."
    while true; do
        status=$(docker inspect --format "{{.State.Status}}" $container_name)

        if [ "$status" == "running" ]; then
            # Debezium Connect takes a while to start up, check if it's ready to accept connections
            ready=$(docker exec $container_name /bin/bash -c "curl -s -o /dev/null -w %{http_code} http://localhost:8083/connectors")

            if [ "$ready" == "200" ]; then
                echo -e "... ${green}READY${reset}"
                break
            fi
        fi
        # Wait before checking again
        echo -n "."
        sleep 1
    done
}

function check_kafka_ui_container() {
    container_name="kafka-ui"
    echo -n "Waiting '$container_name' ."
    while true; do
        status=$(docker inspect --format "{{.State.Status}}" $container_name)

        if [ "$status" == "running" ]; then
            # Kafka UI takes a while to start up, check if it's ready to accept connections
            ready=$(docker exec $container_name /bin/sh -c "busybox wget -qO/dev/null -S http://localhost:8080" 2>&1 | grep -o -E "HTTP/1.1 [0-9]+" | awk '{print $2}')

            if [ "$ready" == "200" ]; then
                echo -e "... ${green}READY${reset}"
                break
            fi
        fi
        # Wait before checking again
        echo -n "."
        sleep 1
    done
}

