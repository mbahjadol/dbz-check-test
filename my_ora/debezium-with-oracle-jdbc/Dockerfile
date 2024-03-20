ARG DEBEZIUM_VERSION
FROM quay.io/debezium/connect:$DEBEZIUM_VERSION
ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc \
    INSTANT_CLIENT_DIR=/instant_client/ \
    DEBEZIUM_CONNECTOR_ORACLE_DIR=$KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-oracle

ARG KAFKA_JDBC_VERSION=10.7.4
ARG JMX_AGENT_VERSION

# Deploy Kafka Connect JDBC
RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
	curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar &&\
    cp $DEBEZIUM_CONNECTOR_ORACLE_DIR/* .

RUN mkdir /kafka/connect/multiple-field-timestamp-converter/
COPY multiple-field-timestamp-converter-1.0.0-jar-with-dependencies.jar /kafka/connect/multiple-field-timestamp-converter/multiple-field-timestamp-converter-1.0.0-jar-with-dependencies.jar

# These should point to the driver version to be used
ENV MAVEN_DEP_DESTINATION=$KAFKA_HOME/libs \
    ORACLE_JDBC_REPO="com/oracle/database/jdbc" \
    ORACLE_JDBC_GROUP="ojdbc8" \
    ORACLE_JDBC_VERSION="21.6.0.0" \
    ORACLE_JDBC_MD5=312e6f4ec9932bbf74a4461669970c4b

RUN docker-maven-download central "$ORACLE_JDBC_REPO" "$ORACLE_JDBC_GROUP" "$ORACLE_JDBC_VERSION" "$ORACLE_JDBC_MD5"

USER root
RUN microdnf -y install libaio && microdnf clean all

USER kafka

COPY oracle_instantclient/* $INSTANT_CLIENT_DIR
COPY oracle_instantclient/xstreams.jar /kafka/libs
COPY oracle_instantclient/ojdbc8.jar /kafka/libs
COPY oracle_instantclient/ojdbc8.jar $KAFKA_CONNECT_JDBC_DIR
COPY oracle_instantclient/ojdbc11.jar /kafka/libs
COPY oracle_instantclient/ojdbc11.jar $KAFKA_CONNECT_JDBC_DIR
