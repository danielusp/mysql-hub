# MySQL HUB

A tool to create a MySQL environment for studies and tests.

MySQL versions:

- 8.0.31
- 5.7.43

## Users and Passwords

| User*      |  Password    |
|-----------|:-------------|
| root      |  test        |
| mytest    |  test123     |

**Obs: In professional projects, be careful using the root user when accessing and manipulating databases.*

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

Log in as root selecting the option ***[Run] MySQL Client as user root***

On Client interface run SQL commands below:

```sql
SOURCE sources/example_db_build.sql
```

## Use MySQL HUB in a external application

It's possible access a MySQL HUB database by host IP. To do this follow the instructions below:

1) Find out the container's IP:

    ```sh
    ./run.sh
    ```

    Select option ***[Show] Container's IP***

2) With the IP number, try to connect MySQL:

    ```sh
    mysql -h [ip-number] -u mytest -p
    ```

    type the correct password, ie '*test123*'

    Example:

    ```sh
    mysql -h 172.17.0.2 -u mytest -p
    ```

**Obs: For this procedure you need to have installed in your local machine the mysql Client*


https://www.educba.com/mysql-versions/