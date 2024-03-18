# Oracle-11g to Oracle-11g

data flow with PostgreSQL as source connector and MySQL as sink connector examples.

In this examples we only test for single table synchronized for simplicity, because the nature complexity of oracle and in this test example we use oracle 11G.

And because the license limitation with oracle even with the oracle client does, you must download manually [Oracle instant client for Linux](http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html), don't forget you must registered in oracle to download it, don't worry it wont come a penny, because we just want the driver for testing this debezium only.

In the time I'm write this doc and test it, I'm using oracle client version 21.13.0.0.0, you can download from it and lookup the zip file, after that put the extracted files under ./ora11_ora11/debezium-with-oracle-jdbc/oracle_instantclient/ , you must create path with name "oracle_instantclient" if not exists yet under that and put all on it.

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
                |      Oracle     |
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
                  |     Oracle     |
                  |                |
                  +----------------+


```
We are using Docker Compose to deploy following components
* Oracle-11g
* Kafka
  * ZooKeeper
  * Kafka Broker
  * Kafka Connect with [Debezium](https://debezium.io/) and  [JDBC](https://debezium.io/documentation/reference/stable/connectors/jdbc.html) Connectors
* Oracle-11g

### Usage
All of the environment setting is stored at env.sh, you can look at there.

#### Running
All processed is almost automatically from creating container setup the connector until you can testing the flow you can only running single command and then you can follow the instruction there.

How to run:

```shell
cd ora11_ora11

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