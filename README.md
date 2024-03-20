# dbz-check-test

debezium combination testing and check for each db connector this repo is collection of debezium unwrap smt based on https://github.com/mbahjadol/debezium-examples unwrap-smt and all additional testing check which using JDBC Sink connector. All of this is fork. 

## Table of Contents

* [Debezium Synchronize](#jdbc-sink)
    * [MySQL to PostgreSQL](my_pg/README.md)
    * [MySQL to MySQL](my_my/README.md)
    * [PostgreSQL to MySQL](pg_my/README.md)
    * [PostgreSQL to PostgreSQL](pg_pg/README.md)
    * [SQLServer to MySQL](sqlsvr_my/README.md)
    * [ MySQL to SQLServer](my_sqlsvr/README.md)
    * [SQLServer to PostgreSQL](sqlsvr_pg/README.md)
    * [PostgreSQL to SQLServer](pg_sqlsvr/README.md)
    * [SQLServer to SQLServer](sqlsvr_sqlsvr/README.md)
    * [Oracle-11g to Oracle-11g ](ora11_ora11/README.md) you must download manually oracle instant client, I'm not provided it because licensing 
    * [MySQL to Oracle](my_ora/README.md) successfully with oracle 21c XE, you must download manually oracle instant client, I'm not provided it because licensing issues. the sink connector is using confluent jdbc.
    * ~~[Oracle to MySQL ](ora_my/README.md)~~ incompleted


