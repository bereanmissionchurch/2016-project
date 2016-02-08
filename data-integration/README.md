# data-integration

## Description

A backend application that usesFlywayDB to maintain the underlying database. It
 provides an easy way to track revision-controlled changes to the underlying database
 objects and is able to sanity check across the entire database on minor changes.

Why FlywayDB?

Because:

1. it integrates nicely with the Play framework through a plugin, which is important
 because this module will inevitably get merged with the larger webserver application

1. it works nicely with jOOQ, allowing the data access layer to be abstracted from raw SQL,
   thus circumventing SQL dialect mis-matches

## Pre-requisites

* Underlying database with the correct role & user set up
  (schema is optional)

## To-do list

* P1: Add unit tests
* P2: Prototype in MySQL
* P2: Flesh out application to hydrate with real data
* P3: Prototype temp tables and tighten DB security

## Dev notes

### How to compile

```./gradlew build```

### Schemas

***this section may get stale;
 refer to the code for descriptions and latest revisions***

* person
* address
* region (R)
* attendance_map
* team_type (R)
* team_map
* small_group
* small_group_map
* foodserving_map
* sunday_school_class_type (R)
* sunday_school_map
* child_map
* song_tag
* song
* song_tag_map
* worship_set
* worship_set_map

Lines marked with (R) explained below

### Notes

* Migration SQL scripts are currently split into a Postgresql folder
 because I'm a lot faster at prototyping in Postgresql but there's a
 decent chance this will have to be ported over to MySQL
* Any ALTER TABLE calls should be checked into a new file within
 /resources/db/migration
  * The file should adhere to the following naming convention:
 
     ```V[major revision]_[current minor revision + 1]__[DDL/DML keyword]_[1+ word description hyphenated]_[TABLE/TEMP_TABLE/VIEW]```
  * major revisions are reserved for contract-breaking changes
  * minor revisions are for all other changes
* For any table designated with (R), the stored data is assumed to be
 static, so any data changes should be checked into a new file within
 /resources/db/migration

## Links
* [FlywayDB Javadoc](http://flywaydb.org/documentation/api/javadoc.html)

