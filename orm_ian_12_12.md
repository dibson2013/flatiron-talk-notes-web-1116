# Object Relational Mapping (ORM) - 12.12.16
## By Ian Candy

## Abstracting our Ruby Objects connection to the Database

We have a Database and Objects that correspond to rows into the database and we have methods to create a table, insert new rows, update rows, delete rows, and make queries to find by certain fields

But we would need to copy the code for every single object that we need to define. That's messy and disgusting. What if there was a way to abstract out all the specifics of each object/table and row/attribute so that we can just create one interface that each of our objects inherit from and can use individually, then we only have to write and change it once!

### Naming a table based on the class name

First we need to name the table.
We always want our class name to be in singular form and the table name to be in plural form and for this we have a useful gem that can pluralize most words. It's called ActiveInflector. We can require it in our project and then call it on our class name to return our tables name:

```ruby
def self.table_name
  self.class.to_s.pluralize
end
```

### Abstracting columns

We want to get all the column names so that we can operate on the db easily, we can get all the columns by defining this method:

```ruby
def self.column_names
  table_info = DB[:conn].execute("PRAGMA #{table_name}")
  table_info.collect do |hash|
    hash['name']
  end.compact
end

self.column_names.each do |column_name|
  attr_accessor(column_name)
end
```

This will get the column names for a table and create getters and setter for each one.

### Namespacing for our ORM

We want to create a namespace for our ORM that contains the class that we want to use:

```ruby
module FlactiveRecord
  class Base

  end
end
```

We'll let everything inherit from this class

```ruby
require_relative 'FlactiveRecord'
class Tweet < FlactiveRecord::Base

  def self.table_name
    self.class.to_s.pluralize
  end

  def self.column_names
    table_info = DB[:conn].execute("PRAGMA table_info(#{table_name}")
    table_info.collect do |hash|
      hash['name']
    end.compact
  end

  self.column_names.each do |column_name|
    attr_accessor(column_name)
  end

  def initialize(options={})
    options.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def self.all
    sql = <<-SQL
      SELECT * FROM #{self.table_name}
    SQL
    results = DB[:conn].execute(sql)
    results.map do |row|
      self.new(result)
    end
  end

  def self.column_names_for_insert
    self.column_names.reject{ |column| column == 'id'}
  end

  def self.columns_for_insert
    self.column_names_for_insert.join(', ')
  end

  def save
    sql = <<-SQL
      INSERT INTO #{self.class.table_name}(#{self.class.column_names_for_insert})
    SQL
    DB[:conn].execute(sql)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{self.class.table_name}")
    self
  end

  private

  def values_for_insert
    values = self.class.columns_for_insert.collect do |column|
      "'#{self.send(column)}'"
    end
    values.join(', ')
  end
end
```

All of these methods are abstracted so that any object can inherit and use them to interact with the db. We define methods for getting the table name based on the current class name, getting the columns from the table, joining those to a string for inserting into the db, getting the values of the instance based on the column names, and saving a new instance to the database with the `#save` method.
