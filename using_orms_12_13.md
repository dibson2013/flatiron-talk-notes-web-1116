# Using ORM's - 12.13.16
## By Ian Candy

### Gems

The require_all gem allows us to add all the files in a certain directory all at once.

include it with `gem 'require_all'`

and in the environment add the folder via `require_all "lib"`

In our gemfile we include `sinatra-activerecord`, `pry`, `sqlite3`

### Making new stuff

When we want to create a class, all we need to do is create a new class and inherit from `ActiveRecord::Base`:

```ruby
class Book < ActiveRecord::Base

end
```
Now the Book class has access to all the methods that it needs in order to manipulate a certain table. Awesome!

But what if there is no table in the database?

### Migrations

In order to create a new table or change the structure in any way, we have to define a migration file. The name of the file is a timestamp plus a description of the changes that are being made.

```ruby
class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :year
      # etc.
    end
  end
end
```
This file is defining queries to be run on our db.

The way we actually run these migrations is by running `rake db:migrate`

### Under the hood

What is happening when we invoke rake is that ActiveRecord is instantiating our CreateBooks class and change method and calls the method.

ActiveRecord will search all the migrations in the `migrate` folder and see if they were run based on a `schema_migration` table. If there is no table ActiveRecord will create it and add the new migration to it. If there is it will add the migration if it doesn't exist.

### Adding an associated table

#### One to Many Relationship

Now if we want to add a new table to our db that is associated with our existing
table in a one to many relationship. We can do this by creating a new table and
adding the foreign key to the existing table. As follows:

```ruby
class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      # etc.
    end
  end
end

class AddAuthorsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :author_id, :integer
  end

end
```

What if we want to

```ruby
class Author < ActiveRecord::Base
   def books
     Book.find_by(author_id: self.id)
   end
end

class Book < ActiveRecord::Base
  def author
    Author.find(self.author_id)
  end
end
```

##### ActiveRecord Magic

Instead of doing the above, ActiveRecord allows you to do this whole thing with
one line in each class:

```ruby
class Author < ActiveRecord::Base
   has_many :books
end

class Book < ActiveRecord::Base
  belongs_to :author
end
```

This will create an association and allow you to get and set and create instances
of the related classes.

#### Many to Many Reationships

What if we want to add a new model that is associated with a table in a many to
many relationship?

Let's say we want to add genres, which has a many to many relationship with books.

We need to create two new tables one for `genres` and one for the association.
