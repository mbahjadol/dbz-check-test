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

SOURCE_ORACLE_HOME=$(docker compose -f ${DC_FILE} exec -T ${SOURCE_NAME} /bin/bash -c "echo \$ORACLE_HOME")
TARGET_ORACLE_HOME=$(docker compose -f ${DC_FILE} exec -T ${TARGET_NAME} /bin/bash -c "echo \$ORACLE_HOME")
#SOURCE_ORACLE_HOME="/u01/app/oracle/product/11.2.0/xe"

qry="insert into inventory.customers (id,first_name,last_name,email) values (1005,'John','Tor','john.tor@example.com');"
docker compose -f ${DC_FILE} exec -T ${SOURCE_NAME} \
    ${SOURCE_ORACLE_HOME}/bin/sqlplus -s \
    ${SOURCE_USER}/${SOURCE_PASSWORD}@${SOURCE_HOST}:${SOURCE_PORT_INTERNAL}/${SYNC_DATABASE_SOURCE} as sysdba<<EOF
    $qry
EOF

echo "Verify the new inserted customer on the ${bold}source database: ${blue}${SOURCE_TYPE}.inventory.customers ${reset}:"
qry="select * from inventory.customers where id=1005;"
docker compose -f ${DC_FILE} exec -T ${SOURCE_NAME} \
    ${SOURCE_ORACLE_HOME}/bin/sqlplus -s \
    ${SOURCE_USER}/${SOURCE_PASSWORD}@${SOURCE_HOST}:${SOURCE_PORT_INTERNAL}/${SYNC_DATABASE_SOURCE} as sysdba<<EOF
    $qry
EOF
echo "${yellow}Please wait for a moment to let the target database catch up with the changes.${reset}"
press_enter

echo "Verify the new inserted customer on the ${bold}target database: ${green}${TARGET_TYPE}.inventory.customers ${reset}:"
qry="select * from inventory.customers where id=1005;"
docker compose -f ${DC_FILE} exec -T ${TARGET_NAME} \
    ${TARGET_ORACLE_HOME}/bin/sqlplus -s \
    ${TARGET_USER}/${TARGET_PASSWORD}@${TARGET_HOST}:${TARGET_PORT_INTERNAL}/${SYNC_DATABASE_TARGET} as sysdba<<EOF
$qry
EOF
echo "${bold}${red}WARNING:${reset} ${red}You should manually verify the new inserted customer on both of source and target database.${reset}"
press_enter
echo "---------------------------------------------"


echo "---------------------------------------------"
echo "${bold}Modifying the email of the customer with id='1005' in the source database.${reset}"
echo "Updating the email of the customer with id='1005' to first_name='mbah', last_name='jadol', and email='mbah.jadol@example.com'"
echo "${bold}${blue}into the 'inventory.customers' table of the source database.${reset}"
echo "---------------------------------------------"

qry="update inventory.customers set first_name='mbah', last_name='jadol', email='mbah.jadol@example.com' where id=1005;"
docker compose -f ${DC_FILE} exec -T ${SOURCE_NAME} \
    ${SOURCE_ORACLE_HOME}/bin/sqlplus -s \
    ${SOURCE_USER}/${SOURCE_PASSWORD}@${SOURCE_HOST}:${SOURCE_PORT_INTERNAL}/${SYNC_DATABASE_SOURCE} as sysdba<<EOF
    $qry
EOF

echo "Verify the modified customer on the ${bold}source database: ${blue}${SOURCE_TYPE}.inventory.customers ${reset}:"
qry="select * from inventory.customers where id=1005;"
docker compose -f ${DC_FILE} exec -T ${SOURCE_NAME} \
    ${SOURCE_ORACLE_HOME}/bin/sqlplus -s \
    ${SOURCE_USER}/${SOURCE_PASSWORD}@${SOURCE_HOST}:${SOURCE_PORT_INTERNAL}/${SYNC_DATABASE_SOURCE} as sysdba<<EOF
    $qry
EOF
echo "${yellow}Please wait for a moment to let the target database catch up with the changes.${reset}"
press_enter

echo "Verify the modified customer on the ${bold}target database$: ${green}${TARGET_TYPE}.inventory.customers ${reset}:"
qry="select * from inventory.customers where id=1005;"
docker compose -f ${DC_FILE} exec -T ${TARGET_NAME} \
    ${TARGET_ORACLE_HOME}/bin/sqlplus -s \
    ${TARGET_USER}/${TARGET_PASSWORD}@${TARGET_HOST}:${TARGET_PORT_INTERNAL}/${SYNC_DATABASE_TARGET} as sysdba<<EOF
$qry
EOF
echo "${bold}${red}WARNING:${reset} ${red}You should manually verify the modified customer on both of source and target database.${reset}"
press_enter
echo "---------------------------------------------"


echo "---------------------------------------------"
echo "${bold}Deleting the customer with id='1005' from the source database.${reset}"
echo "Deleting the customer with id='1005'"
echo "${bold}${blue}from the 'inventory.customers' table of the source database.${reset}"
echo "---------------------------------------------"

qry="delete from inventory.customers where id=1005;"
docker compose -f ${DC_FILE} exec -T ${SOURCE_NAME} \
    ${SOURCE_ORACLE_HOME}/bin/sqlplus -s \
    ${SOURCE_USER}/${SOURCE_PASSWORD}@${SOURCE_HOST}:${SOURCE_PORT_INTERNAL}/${SYNC_DATABASE_SOURCE} as sysdba<<EOF
    $qry
EOF

echo "Verify the deleted customer on the ${bold}source database: ${blue}${SOURCE_TYPE}.inventory.customers ${reset}:"
qry="select * from inventory.customers where id=1005;"
docker compose -f ${DC_FILE} exec -T ${SOURCE_NAME} \
    ${SOURCE_ORACLE_HOME}/bin/sqlplus -s \
    ${SOURCE_USER}/${SOURCE_PASSWORD}@${SOURCE_HOST}:${SOURCE_PORT_INTERNAL}/${SYNC_DATABASE_SOURCE} as sysdba<<EOF
    $qry
EOF
echo "${yellow}Please wait for a moment to let the target database catch up with the changes.${reset}"
press_enter

echo "Verify the deleted customer on the ${bold}target database$: ${green}${TARGET_TYPE}.inventory.customers ${reset}:"
qry="select * from inventory.customers where id=1005;"
docker compose -f ${DC_FILE} exec -T ${TARGET_NAME} \
    ${TARGET_ORACLE_HOME}/bin/sqlplus -s \
    ${TARGET_USER}/${TARGET_PASSWORD}@${TARGET_HOST}:${TARGET_PORT_INTERNAL}/${SYNC_DATABASE_TARGET} as sysdba<<EOF
$qry
EOF
echo "${bold}${red}WARNING:${reset} ${red}You should manually verify the deleted customer on both of source and target database.${reset}"
press_enter
echo "---------------------------------------------"
