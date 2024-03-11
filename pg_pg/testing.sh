#!/bin/bash

source ./env.sh

echo "---------------------------------------------"
echo "Make Addition, Modification, and Deletion tests on the source database, and verify the changes on the target database."
echo "---------------------------------------------"

echo "---------------------------------------------"
echo "${bold}Adding a new customer to the source database.${reset}"
echo "Inserting new data with id='1005', first_name='John', last_name='Tor', and email='john.tor@example.com'"
echo "${bold}${blue}into the 'inventory.customers' table of the source database.${reset}"
echo "---------------------------------------------"
docker compose -f ${DC_FILE} exec -u postgres ${SOURCE_NAME} \
    psql -c \
    "insert into inventory.customers (id,first_name,last_name,email) \
     values (1005,'John','Tor','john.tor@example.com');"
echo "Verify the new inserted customer on the ${bold}source database: ${blue}postgresql.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -u postgres ${SOURCE_NAME} \
    psql -c "select * from inventory.customers where id=1005;"
press_enter
echo "Verify the new inserted customer on the ${bold}target database$: ${green}mysql.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -u postgres ${TARGET_NAME} \
    psql -c \
    "select * from inventory.customers where id=1005;"
echo "${bold}${red}WARNING:${reset} ${red}You should manually verify the new inserted customer on both of source and target database.${reset}"
press_enter
echo "---------------------------------------------"


echo "---------------------------------------------"
echo "${bold}Modifying the email of the customer with id='1005' in the source database.${reset}"
echo "Updating the email of the customer with id='1005' to first_name='mbah', last_name='jadol', and email='mbah.jadol@example.com'"
echo "${bold}${blue}into the 'inventory.customers' table of the source database.${reset}"
echo "---------------------------------------------"
docker compose -f ${DC_FILE} exec -u postgres ${SOURCE_NAME} \
    psql -c \
    "update inventory.customers set first_name='mbah', last_name='jadol', email='mbah.jadol@example.com' where id=1005;"
echo "Verify the modified customer on the ${bold}source database: ${blue}postgresql.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -u postgres ${SOURCE_NAME} \
    psql -c "select * from inventory.customers where id=1005;"
press_enter
echo "Verify the modified customer on the ${bold}target database$: ${green}mysql.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -u postgres ${TARGET_NAME} \
    psql -c \
    "select * from inventory.customers where id=1005;"
echo "${bold}${red}WARNING:${reset} ${red}You should manually verify the modified customer on both of source and target database.${reset}"
press_enter
echo "---------------------------------------------"


echo "---------------------------------------------"
echo "${bold}Deleting the customer with id='1005' from the source database.${reset}"
echo "Deleting the customer with id='1005'"
echo "${bold}${blue}from the 'inventory.customers' table of the source database.${reset}"
echo "---------------------------------------------"
docker compose -f ${DC_FILE} exec -u postgres ${SOURCE_NAME} \
    psql -c "delete from inventory.customers where id=1005;"
echo "Verify the deleted customer on the ${bold}source database: ${blue}postgresql.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -u postgres ${SOURCE_NAME} \
    psql -c "select * from inventory.customers where id=1005;"
press_enter
echo "Verify the deleted customer on the ${bold}target database$: ${green}mysql.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -u postgres ${TARGET_NAME} \
    psql -c \
    "select * from inventory.customers where id=1005;"
echo "${bold}${red}WARNING:${reset} ${red}You should manually verify the deleted customer on both of source and target database.${reset}"
press_enter
echo "---------------------------------------------"
