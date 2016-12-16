# MVC and Web App Architecture - 12.15.16
## By Ian Candy

### What are design patterns?

Over time, we realize that certain patterns are helpful to making our apps
behave consistently and can be reused in other project and can be taught to
many developers so that it's easy to modify or understand the code.

### MVC

MVC stands for Model-View-Controller

![MVC](http://csharpcorner.mindcrackerinc.netdna-cdn.com/UploadFile/3d39b4/Asp-Net-mvc-introduction/Images/MVC-Introduction2.jpg)

### Classes for MVC

class BookController
class Book
class BookView

### Sinatra

Sinatra is a web framework that automatically creates a web server and help us make routing easy. Here is an example of a sinatra app:

```ruby
require 'sinatra'

get '/' do
  "Hello World"
end
```

This is the equivalent of a Rack app that looks like this:

```ruby
def call(env)
  req = Rack::Request.new(env)
  path = req.path
  if req.get? && path == '/'
    response_body = '<h1>Welcome Home</h1>'
  end
  [200, {}, [response_body]]
end
```

We can put our Sinatra code in a class called Application Controller.

### Separating Controllers

We have many different resources in our app and if we put everything in the ApplicationController Class it will get messy quick.

In order to make things neater, we should define a controller for each model.

```ruby
class BookController < ApplicationController
  def index
    get '/books' do
      @books = Book.all
      render('index.html.erb')
    end
  end
end
```

```ruby
@books.each do |book|
  <!-- <h1> <%= book.title %>... -->
end
```

If we want to get params from the URL we can use this syntax:

```ruby
get '/books/:id' do
  @book = Book.find(paras[:id])
end

```
