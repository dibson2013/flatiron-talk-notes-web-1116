# Object Oriented Concepts Part 3 -- Has Many Through Relationships
## By Ian Candy

### Separation of Concerns

At this point we have Authors and Books
and each Book has a genre property

Maybe we should make a class for the Genres:

```ruby
class Genre
  attr_reader :name

  ALL = []

  def initialize(name
    @name = name
    ALL << self
  end

end
```
#### Defining the Relationship

We should decide what the Relationship between Genre and Book is and in this case we want `Book` to belong to a `Genre` and `Genre` to have many `Book`s

In order to make this happen we want to add a reader to Genre that will allow it to get all the books in an instance of `Genre` i.e. `Western`

```ruby
class Genre
  attr_reader :name, :books

  ALL = []

  def initialize(name)
    @name = name
    ALL << self
  end

end
```

We also need to add

```ruby
class Book
  attr_reader :genres, :title, :description

  def initialize(title, description)
    @genres = []
  end

  def add_genre(genre)
    @genres << genre
    genre.books << self
  end

end
```

and then call the method in a runner file

```ruby
book = Book.new('Hombre', "A western novel about a gunslinger")
genre = Genre.new("Western")

book.add_genre(genre)
```

This will add a genre to the `Book`'s genres array and also add the book instance(via self) to the `Genre` class so that we can keep track of it there.

We can get all the genres of a book by calling `book.genres` and we can see all the books in a genre by accessing `Genre::ALL`.

### Modeling a third Relationship

Now we want to be able to model the `Author` Relationship with the `Genre`
so again it will probably be a has many relationship both ways.

```ruby
class Genre

  def authors
    # Look at collection of books
    # Add each book's author to array and return it
    books.collect { |book| book.author }.uniq
  end

end
```

This will add the author instance that is stored in each book to the collect and it will return an array of all of those instances.


```ruby

class Author  

  def genres
    self.books.collect { |book| book.genres }.flatten.uniq
    # -> array in the form of [<Genre1>, <Genre2>, <Genre3>]
  end

end
```

### Has many through

What we are seeing above is that the `Author` and `Genre` classes don't have to interact with each other in order to
know about each other. All they need to do is access the `Book` class which has all the `Genre` instances and all the `Author` instances.

![Booyah](images/booyah.gif)
