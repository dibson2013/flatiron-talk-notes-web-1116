# Intro To SQL - 12.7.16
## By Ian

### Relational Databases

Edgar Cobb invented the concept of relational Databases.

The main idea of the database is that one table of data can have a relationship with a completely different table of data.

```SQL
CREATE TABLE
```

Here is a sample to get all artists:

```SQL
SELECT * FROM artists;
```

This will return a row with the title artists

Now if we wanted to get `Black Sabbath` we run this query:

```SQL
SELECT * FROM artists
WHERE name = 'Black Sabbath';
```

If we wanted to get all the artists with the word `black` in it, we can do:

```SQL
SELECT * FROM artists
WHERE name LIKE '%Black%';
```

This will return all the artist that contain the word like.

### Schema

How do I rewrite the schema to add the concept of a fan into the database?

```SQL
CREATE TABLE fans(
	id INTEGER PRIMARY KEY,
	name TEXT,
	artistId INTEGER
);
```

We could do this, but then each fan will only be able to have one artist that they are a fan of.

So what we can do is create a whole new table to store just the relationships between the artists and the fans.

There will be a column for artistId and fanId and each artistId will have multiple fans and vise versa.

### Adding new rows

```SQL
INSERT INTO fans
(name, artistID)
values ('Stan', 2);
```

### Puffy Problem

What happens when you keep changing your name, like Sean Combs aka Puff Daddy aka Sean Diddy aka P Diddy aka you get the point..

We want to keep our naming consistent and not change our names of things too often otherwise things will break.

### Changing a row value

We can change a row value by calling update

```SQL
UPDATE fans
SET name="Ruff Magician"
WHERE name="Stan";
```
