#!/bin/bash

source ./env.sh

# echo "Removing topic: ${TOPIC_PREFIX}"
# ./remove-topic.sh ${TOPIC_PREFIX}

topics=$(echo "$SYNC_TABLE_LIST" | tr ',' ' ')

# Loop over the topics and call to delete topic
for topic in $topics; do
    echo "Removing topic: ${TOPIC_PREFIX}_$topic"
    docker compose -f ${DC_FILE} exec kafka \
        /kafka/bin/kafka-topics.sh \
        --bootstrap-server kafka:9092 \
        --delete --topic "${TOPIC_PREFIX}_$topic"
done


# # Get the list of all connectors
# topics=$(docker-compose -f ${DC_FILE} exec kafka \
#     /kafka/bin/kafka-topics.sh \
#     --bootstrap-server kafka:9092 \
#     --list --exclude-internal)

# exclude_topics="${STATUS_STORAGE_TOPIC} ${OFFSET_STORAGE_TOPIC} ${CONFIG_STORAGE_TOPIC}"

# # Loop over the topics and echo
# for topic in $topics; do
#     if [[ " ${exclude_topics} " =~ " ${topic} " ]]; then
#         #echo "Skipping topic: $topic"
#         continue
#     fi
#     echo "Removing topic: $topic"
#     docker-compose -f ${DC_FILE} exec kafka \
#         /kafka/bin/kafka-topics.sh \
#         --bootstrap-server kafka:9092 \
#         --delete --topic $topic
# done

