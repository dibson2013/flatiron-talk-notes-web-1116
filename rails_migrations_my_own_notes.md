# ActiveRecord Migrations

### What are migrations?

In order for us to create a database and also keep track of the changes that were made to the structure over time, we have to put the commands we give to our database in files. These files are called migrations.

Here is an example of a simple migration

```ruby
# Migrations are contained in classes that inherit from ActiveRecord::Migration
# which contain all the database commands wrapped in ruby functions
class AddSsl < ActiveRecord::Migration
  # many times a migration will define an up and down method
  # in order to easily allow someone to undo the changes
  def up
    # we are adding a column to the accounts table
    # the field is called ssl_enables and the type is a boolean
    # by default, the value is true
    add_column :accounts, :ssl_enabled, :boolean, default: true
  end

  def down
    remove_column :accounts, :ssl_enabled
  end
end

```

This is a simple example, here is one that is a little more complex:

```ruby
class AddSystemSettings < ActiveRecord::Migration
  def up
    # We are creating a table called system_settings
    # with all the fields described in the do block
    create_table :system_settings do |t|
      t.string  :name
      t.string  :label
      t.text    :value
      t.string  :type
      t.integer :position
    end

    # This creates a first row of the table with name, label, and value
    SystemSetting.create  name:  'notice',
                          label: 'Use notice?',
                          value: 1
  end

  def down
    drop_table :system_settings
  end
end
```

The available methods inside a migration class are as follows:
- `create_table(name, options)`: will create a table with the name
and the options that are passed in, this can be the form of a block of columns and types i.e `t.string :name` etc.
- `drop_table`
-  `change_table(name, options)` similar to create table but instead of creating, it can add or remove a column and can add indexes or foreign keys
- `rename_table(old_name, new_name)`
- `add_column(table_name, column_name, type, options)` adds a new column to the table
- `rename_column(table_name, column_name)`
- `change_column(table_name, column_name, type, options)` changes the column type or options
- `remove_column(table_name, column_name)`
- `add_index(table_name, column_names, options)`
- `remove_index(table_name, column: column_name)`
- `remove_index(table_name, name: index_name)`

### Generating Migration files with Rails

rails provides an easy way to create new migrations via the following command:

`rails generate migration MyNewMigration`

This will generate a new class file titled my_new_migration.rb, prepended by the timestamp of the migration.

We can also pass along a field and type in the options and rails will create a corresponding command to create that field in the migration file:

`rails generate migration add_fieldname_to_tablename fieldname:string`

will generate something that looks like this:

```ruby
class AddFieldnameToTablename < ActiveRecord::Migration
  def change
    add_column :tablenames, :field, :string
  end
end
```

In order to apply these changes to the db we need to run the migrations agains the database. We have a handy tool that will do this and create a `schema_migrations` table based on all the current migrations, and also update the `schema.rb` file.

### Rolling back changes

running the command `rake db:rollback` will undo the most recent migration and running `rake db:rollback VERSION=x` will roll the db back to a specific version within your migrations or `rake db:rollback STEP=x` will rollback the schema by x amount of migrations.

### Changing a model based on a migration

In order to change the model at the same time we're changing the db, we can make a call to `Base#create_column_information` but this is not usually the case.
