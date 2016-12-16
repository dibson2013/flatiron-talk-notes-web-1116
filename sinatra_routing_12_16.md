# Sinatra Routing - 12.16.16
## By Ian

### HTTP

HTTP is a protocol that allows different computers to communicate with each other over the web. It is based on a simple request response model and there are mainly 4 types of requests.

### HTTP Verbs and CRUD

GET - Read
POST - Create
DELETE - Destroy
PUT/PATCH - Update

Early browsers only supported GET and POST [Wikipedia - Web Browser](https://en.wikipedia.org/wiki/Web_browser)

Recently, Chrome has started to support the other verbs that are available through the protocol.

### GET

GET is the simplest verb and doesn't really require any explanation so I'm not going to write any. So you want to know why I wrote that whole section and I am continuing to write more? Well, that's a really good question and I don't really know, I have to go now, bye!

### Forms AKA Your Life

How do we make POST requests to the server?

```html
<form  action="/" method="post">

</form>
```

### Things that the user needs to do

1. The user should be able to request a form
2. The user should be able to submit the form - submitting the form
should make a 'POST' request
3. When we receive the 'POST' request, we should save the new book to the database based on the user input
4. After the book is saved, redirect to the show page for that particular book

### Controllers for CRUD

```ruby
class BooksController < ApplicationController

  get '/books' do
    @books = Book.all
    erb :books/index
  end

  get '/books/new' do
    erb :books/new
  end

  get '/books/:id' do
    @book = Book.find(params[:id])
    erb :show
  end

  post '/books' do
    book = Book.new(title: params[:title], snippet: params[:snippet])
    book.save
    id = book.id
    redirect to "/books/#{id}"
  end
end
```

The form that the user would submit would contain the following in the form tag:

```html
<form action="/books" method="post">

</form>
```

In order to get the input that the user entered into the form we have to name each input tag and the name attribute will correspond to the key and the value of the input would be the value in the params hash.

```html
<input type="text" name="title" >
<input type="text" name="snippet" >
```

### Law of Demeter

Using method chaining in a way that relies on other objects that are not reliable.

### Creating a resource specific hash from form

In order to create a hash of all the fields of `books`, we want to have a nested hash with the keys of `books`

params = `{'books' => {'title' => 'Harry Potter', 'snippet' => 'A muggle discovers that he is a magician'}}`

We can do this by setting nested names:

```html
<input type="text" name="books[title]" >
<input type="text" name="books[snippet]" >
```
