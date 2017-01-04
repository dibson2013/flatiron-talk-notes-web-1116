# Sinatra Routes - 12.20.16
## By Ian Candy

A browser can only send `get` and `post` requests.
How can we use the `put` and `delete` methods in our server?

We can add a hidden field in our form with a `_method` name and a value of `put` or `delete`.


### Adding Genres to our Books


If we want to give the user the option to add genres to the app.
We already have a genre table and model. Let's start with the Controller:



```ruby
class GenresController < ApplicationController

  get '/genres/new' do
    erb :new
  end

  post '/genres' do
    Genre.create(params[:genre])
    redirect :books
  end

end
```

And the new Genre Form:


```html
<form class="" action="/genres" method="post">
  <input type="text" name="genre[name]" >
  <input type="submit" value="Submit">
</form>
```

### Associating Genres with Books

Now how do we associate the genre that we created with the book?

#### The Bad Way

Let's say we want to add the genres every time we create a new book:



```html
<form class="" action="/books" method="post">
  <input type="text" name="books[title]" value="">
  <input type="text" name="books[snippet]" value="">
  <input type="text" name="books[genres][]">
  <input type="text" name="books[genres][]">
  <input type="text" name="books[genres][]">
</form>
```

This will create a new array and params will now contain:

`{'genres' => ['1', '2', '3']}`

On the server side we can iterate through each of the genre ids

```ruby
@book = Book.create(params[:books][:name], ...)

params[:books][:genres].each do |genre_id|
  BookGenres.create(book_id: @book.id, genre_id: genre_id)
end
```

This will actually work and create associations in the BookGenre Table.
But the interface stinks, the user has to remember which id each genre is.

#### The Better Way - Checkboxes

We have the option of adding checkboxes to the form, getting them dynamically from the Genre Model:

```ruby
post '/books' do
  @book = Book.create(params[:books])
  @genres = Genre.all
end
```

```html
<% @genres.each do |genre| %>
  <input type="checkbox" name="books[genre_ids][]" value="<%= genre.id %>">
<% end %>
```

This will render a list of all the names of the genres with checkboxes and if the
checkboxes are checked it will submit that id into the array.

On the sever we would have to do something like this:

```ruby
Book.create(name: .., genre_ids: params[:books][:genre_ids])
```

But the problem is, we have to add each association in the array to the association table.

We have to define a setter method for the Book class

```ruby
def genre_ids=(genre_ids)
  genre_ids.each do |genre_id|
    BookGenre.create(book_id: self.id, genre_id: genre_id)
  end
end
```

#### The Best Way - ActiveREcord

Here comes ActiveRecord, it does it all for you!
[ActiveRecord Docs](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)

The `#genre_ids=` method is implemented automatically when we define the association of has_many genres in the `Book` class. 
