# Object Relational Mapping
## By Ian Candy

### Why do we need an ORM?

Working directly with SQL is extremely difficult and not practical, also we need to integrate our db with the rest of our app, so we need a way to take the information from the db and use it in our app. What we have for that is an ORM which maps db entries to Ruby Objects.

### Typical Pattern of ORM

We would usually define an object to initialize with a default of an empty hash and accept any expected arguments.

```ruby
class Tweet
  def initialize(argument)
    @argument = argument
  end
end
```


```Ruby
class TweetsApp
  def call

  end
end
```


```ruby
def get_tweets
  # We can use the multiline string to get syntax
  # highlighting and keeping the query in a
  # different variable.
  query = <<-SQL
    SELECT * FROM tweets
  SQL
  tweets = DB[:conn].execute(query)
  tweets.each do |tweet|
  Tweet.new(tweet)
  end
end
```
### Make and Rake




```ruby

def create(username, message)
  query = "INSERT INTO tweets(username, message) VALUES (#{username}, #{message})"
  save
end

def find(id)
  "SELECT * FROM tweets WHERE id = #{id}"
end

def update(id, name, message)
  "UPDATE "
end
```
