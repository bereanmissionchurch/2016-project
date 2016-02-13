# data-integration

## Table of Contents
1. [Description](#description)
1. [Schema](#schema)
1. [Pre-requisites](#pre_reqs)
1. [To-do list](#to_do)
1. [Developer's section](#dev_section)
1. [Links](#links)

<div id='description'/>
## Description

A backend application that usesFlywayDB to maintain the underlying database. It provides an easy way to track revision-controlled changes to the underlying database objects and is able to sanity check across the entire database on minor changes.

Why FlywayDB?

Because:

1. it integrates nicely with the Play framework through a plugin, which is important because this module will inevitably get merged with the larger webserver application

1. it works nicely with jOOQ, allowing the data access layer to be abstracted from raw SQL, thus circumventing SQL dialect mis-matches, speeding up development, and minimizing error
   
1. it allows us to easily revision-control changes to the underlying database, and provides an easy way for us to migrate databases and make revisions with minimal pain

<div id='schema'/>
## Schema

***this section may get stale; refer to the code for latest revisions***

* ```person```  
  The main table storing various information about persons
* ```address```  
  A 1:1 mapping of a person and their address; separated from the person table because addresses are optional
* ```region``` (R)  
  A 1:1 mapping of a geographical region's name and an internal ID; used for saving space and optimizing joins
* ```attendance_map``` (A)  
  A mapping of a member to their (Sunday) attendance for attendance tracking
* ```team_type``` (R)  
  A 1:1 mapping of various Berean member team names and their internal ID's; used for saving space and optimizing joins
* ```team_map``` (A)  
  A mapping of a member to their respective team(s) with a column for distinguishing leaders
* ```small_group```  
  A table storing various information about small groups of the past, present, and future
* ```small_group_map``` (A)  
  A mapping of a member to their small group(s) of the past, present, and future
* ```foodserving_map``` (A)  
  A mapping of a member to when they are serving food
* ```sunday_school_class_type``` (R)  
  A 1:1 mapping of a Sunday school class type and an internal ID; used for saving space and optimizing joins
* ```sunday_school_map``` (A)  
  A mapping of a member to when they are serving in Sunday school
* ```child_map```  
  A mapping of any child to their parent(s)
* ```song``` (A)  
  A table storing various information about songs
* ```song_tag```  
  A mapping of a song tag's name and an internal ID; used for saving space and optimizing joins
* ```song_tag_map``` (A)  
  A mapping of a song to its tag(s)
* ```worship_set```  
  A mapping of a worship set for the past, present, and future to its leader
* ```worship_set_map```  
  A mapping of a worship set to its songs


Lines marked with (R) explained in the notes of the [Developer's section](#dev_section)

Lines marked with (A) strongly suggest append-only tables (DELETE DML statements should be limited, but UPDATE DML statements should never happen)

<div id='pre_reqs'/>
## Pre-requisites

* Underlying database with the correct role & user set up
    * database properties go in ```config.properties```
    * creating the schema beforehand is not necessary
    * for developers, more details are in the [Developer's section](#dev_section)

<div id='to_do'/>
## To-do list

* P1: Add unit tests
* P2: Flesh out application to hydrate with real data; leverage jOOQ for this
* P3: Prototype temp tables and tighten DB security
    * temp tables (at least global ones) are not possible in MySQL
    * best alternative is to create local temp tables during runtime; leverage jOOQ for this

<div id='dev_section'/>
## Developer's section

### Setting up the environment

#### Leveraging an IDE (optional)

If using IntelliJ, then run:
```shell
./gradlew idea
```
If using Eclipse, then run:
```shell
./gradlew eclipse
```
Finally, use the IDE to open this as a gradle project

#### Installing a local database instance

Required for testing locally, MySQL instructions omitted because the installer isn't easily accessible

**INSTRUCTIONS ARE OSX SPECIFIC**

1. [Install brew](http://brew.sh/)
2. Install PostgresSQL
```shell
brew install postgresql
```
3. Initialize a database and start it
```shell
# change the path as desired
initdb -D ~/bmc
pg_ctl -D ~/bmc start
```
4. Connect to the database to set up a user
```shell
psql -d bmc -c "CREATE USER bmc WITH PASSWORD 'bmc';"
```


### Compiling & running

```shell
./gradlew clean build run
# or if you want to pass in arguments
./gradlew clean build
java -jar ./build/libs/data-integration-$VERSION.jar (migrate|validate|clean|info|baseline|repair)...
```

### Notes

* Migration SQL scripts are currently split between a PostgreSQL folder, a MySQL folder, and a shared folder
    * any migration scripts going into the shared folder **must** be compatible with both dialects
    * keep dialect-specific migration scripts to a minimum, but put them in their respective folders
    * version naming schemes may collide and are expected to collide between the PostgreSQL folder and the MySQL folder, but may **not** collide with the shared folder
    * any new migration file should adhere to the following naming convention:  
      ```V[major revision]_[current minor revision + 1]__[DDL/DML keyword]_[description]_[SQL keywords as necessary].sql```
        * major revisions are reserved for contract-breaking changes
        * minor revisions are for all other changes
* For any table designated with an (R) in the [above list](#schema), the stored data is assumed to be static, so any INSERTs need to be checked in

<div id='links'/>
## Links
* [FlywayDB Javadoc](http://flywaydb.org/documentation/api/javadoc.html)
* [MySQL 5.7 Documentation](http://dev.mysql.com/doc/refman/5.7/en/)
* [PostgreSQL 9.5 Documentation](http://www.postgresql.org/docs/9.5/static/index.html)

