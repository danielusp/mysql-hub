# MySQL HUB

A tool to create an MySQL enviroment to study and make tests.

MySQL versions:

- 8.0.31
- 5.7.43

## Users and Passwords

| User      |  Password    |
|-----------|:-------------|
| root      |  test        |
| mytest    |  test123     |

## How to run a MySQL Server

Run options menu:

```sh
./run.sh
```

Select option ***[Run] MySQL 8.0.31 Server*** or ***[Run] MySQL 5.7.43 Server***

## How to run a MySQL Client

After the container creation, run the client to interact using SQL language:

```sh
./run.sh
```

Select option ***[Run] MySQL Client as user mytest*** or ***[Run] MySQL Client as user root***

After enter the correct password you'll see a Welcome message and a prompt to start SQL interactions.

```sh
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is ...
Server version: 8.0.31 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

Type *exit* to go out of Client's enviroment.

## Stop MySQL Server

To stop the container

```sh
./run.sh
```

Select option ***[Stop] MySQL Server***

## DB example

There's an example in *sources/example_db_build.sql*. To create and load data:

Run options menu:

```sh
./run.sh
```

Select option ***[Run] MySQL Client as user mytest***

On Client interface run SQL commands below:

```sql
SOURCE sources/example_db_build.sql
```