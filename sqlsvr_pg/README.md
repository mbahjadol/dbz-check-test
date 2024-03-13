# SQLServer to PostgreSQL

data flow with SQLServer as source connector and MySQL as sink connector examples.

[<< Back to dbz-check-test Root](../README.md)

## Table of Contents

* [Topology](#topology)
    * [Usage](#usage)
        * [Running](#running)
          * [Testing](#testing)         
        * [Stopping](#stopping)


### Topology


```
                +-----------------+
                |                 |
                |    SQLServer    |
                |                 |
                +---------+-------+
                          |
                          |
                          |
          +---------------v------------------+
          |                                  |
          |           Kafka Connect          |
          |  (Debezium, JDBC connectors)     |
          |                                  |
          +---------------+------------------+
                          |
                          |
                          |
                          |
                  +-------v--------+
                  |                |
                  |   PostgreSQL   |
                  |                |
                  +----------------+


```
We are using Docker Compose to deploy following components
* SQLServer
* Kafka
  * ZooKeeper
  * Kafka Broker
  * Kafka Connect with [Debezium](https://debezium.io/) and  [JDBC](https://debezium.io/documentation/reference/stable/connectors/jdbc.html) Connectors
* PostgreSQL

### Usage
All of the environment setting is stored at env.sh, you can look at there.

#### Running
All processed is almost automatically from creating container setup the connector until you can testing the flow you can only running single command and then you can follow the instruction there.

How to run:

```shell
cd sqlsvr_pg

# Starting up
./start.sh

```


#### Testing

You can follow the instruction there, which test adding, modify, and deletion test.


#### Stopping
How to stop:

```shell
# Stopping 
./stop.sh

```




[<< Back to dbz-check-test Root](../README.md)