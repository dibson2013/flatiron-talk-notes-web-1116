# Intro to Database Design
## By Tony Guerrero

### Creating structure diagrams

It's important to map out the structure of the Database with diagrams in order to easily see what the schema looks like.

### What is a database?

A database is simply something that stores the data in columns and rows, similar to a spreadsheet.

### Why can't we just use spreadsheets?

- They are limited in size
- Collaboration is really hard
- Mistakes cannot be detected easily
- Redundancy happens very often

### There are many DB Management systems

Postres, Mysql, mongo, oracle, etc. are all systems to manage a db.

Walmart switched their database to mongo on black friday, because they just want to get as much data as possible at once.

There are trade-off to every system, the most commonly used ones are SQL based.

### Sharding

Sometimes db architects split db's into many different dbs to include performance.

### What is a table?

A collection of data with columns and rows.

doctor has specialty, patient has primary doctor, several doctors work at a clinic, patient has several prescription,

### Cardinality

the number of elements in a set or other grouping, as a property of that grouping.

There are 3 degrees:
- one-to-one
- one-to-many
- many-to-many
