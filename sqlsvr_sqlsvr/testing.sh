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

qry="SET IDENTITY_INSERT customers ON; \
    insert customers (id,first_name,last_name,email) \
        values (1005,'John','Tor','john.tor@example.com'); \
    SET IDENTITY_INSERT customers OFF;" 
echo $qry | docker compose -f ${DC_FILE} exec -T -i ${SOURCE_NAME} bash -c \
    "$SQLCMD -U $SOURCE_USER -P $SOURCE_PASSWORD -d $SYNC_DATABASE_SOURCE"

echo "Verify the new inserted customer on the ${bold}source database: ${blue}${SOURCE_TYPE}.inventory.dbo.customers ${reset}:"
docker compose -f ${DC_FILE} exec -T -i ${SOURCE_NAME} bash -c \
    "$SQLCMD -U $SOURCE_USER -P $SOURCE_PASSWORD -d $SYNC_DATABASE_SOURCE -Q 'select * from $SYNC_SCHEMA_SOURCE.customers where id=1005;'"
press_enter

echo "Verify the new inserted customer on the ${bold}target database$: ${green}${TARGET_TYPE}.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -T -i ${TARGET_NAME} bash -c \
    "$SQLCMD -U $TARGET_USER -P $TARGET_PASSWORD -d $SYNC_DATABASE_TARGET -Q 'select * from $SYNC_SCHEMA_TARGET.customers where id=1005;'"
echo "${bold}${red}WARNING:${reset} ${red}You should manually verify the new inserted customer on both of source and target database.${reset}"
press_enter
echo "---------------------------------------------"


echo "---------------------------------------------"
echo "${bold}Modifying the email of the customer with id='1005' in the source database.${reset}"
echo "Updating the email of the customer with id='1005' to first_name='mbah', last_name='jadol', and email='mbah.jadol@example.com'"
echo "${bold}${blue}into the 'inventory.customers' table of the source database.${reset}"
echo "---------------------------------------------"

qry="update $SYNC_SCHEMA_SOURCE.customers set first_name='mbah', last_name='jadol', email='mbah.jadol@example.com' where id=1005;"
echo $qry | docker compose -f ${DC_FILE} exec -T -i ${SOURCE_NAME} bash -c \
    "$SQLCMD -U $SOURCE_USER -P $SOURCE_PASSWORD -d $SYNC_DATABASE_SOURCE"

echo "Verify the modified customer on the ${bold}source database: ${blue}${SOURCE_TYPE}.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -T -i ${SOURCE_NAME} bash -c \
    "$SQLCMD -U $SOURCE_USER -P $SOURCE_PASSWORD -d $SYNC_DATABASE_SOURCE -Q 'select * from $SYNC_SCHEMA_SOURCE.customers where id=1005;'"
press_enter

echo "Verify the modified customer on the ${bold}target database$: ${green}${TARGET_TYPE}.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -T -i ${TARGET_NAME} bash -c \
    "$SQLCMD -U $TARGET_USER -P $TARGET_PASSWORD -d $SYNC_DATABASE_TARGET -Q 'select * from $SYNC_SCHEMA_TARGET.customers where id=1005;'"
echo "${bold}${red}WARNING:${reset} ${red}You should manually verify the modified customer on both of source and target database.${reset}"
press_enter
echo "---------------------------------------------"


echo "---------------------------------------------"
echo "${bold}Deleting the customer with id='1005' from the source database.${reset}"
echo "Deleting the customer with id='1005'"
echo "${bold}${blue}from the 'inventory.customers' table of the source database.${reset}"
echo "---------------------------------------------"
docker compose -f ${DC_FILE} exec -T -i ${SOURCE_NAME} bash -c \
    "$SQLCMD -U $SOURCE_USER -P $SOURCE_PASSWORD -d $SYNC_DATABASE_SOURCE -Q 'delete from $SYNC_SCHEMA_SOURCE.customers where id=1005;'"

echo "Verify the deleted customer on the ${bold}source database: ${blue}${SOURCE_TYPE}.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -T -i ${SOURCE_NAME} bash -c \
    "$SQLCMD -U $SOURCE_USER -P $SOURCE_PASSWORD -d $SYNC_DATABASE_SOURCE -Q 'select * from $SYNC_SCHEMA_SOURCE.customers where id=1005;'"
press_enter

echo "Verify the deleted customer on the ${bold}target database$: ${green}${TARGET_TYPE}.inventory.customers ${reset}:"
docker compose -f ${DC_FILE} exec -T -i ${TARGET_NAME} bash -c \
    "$SQLCMD -U $TARGET_USER -P $TARGET_PASSWORD -d $SYNC_DATABASE_TARGET -Q 'select * from $SYNC_SCHEMA_TARGET.customers where id=1005;'"
    
echo "${bold}${red}WARNING:${reset} ${red}You should manually verify the deleted customer on both of source and target database.${reset}"
press_enter
echo "---------------------------------------------"
