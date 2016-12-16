# How The Internet Works
## By Ian Candy

### Servers

Now that we have our Database and Ruby code working together how do we let people
see it on the internet?

The answer is through a server.

### Rack
Rack is a gem that contains all the functionality necessary to serving things to
the internet.

We can use it in our program with `require "rack"`.

### Rack Compliance

How does Rack know about the app that is running and passing information to it?

We have something called rack compliance that ensures in a framework like Sinatra or
Rails that interacts with Rack follows certain rules that makes it easy to communicate.

### Creating a Server

So how do we go about creating a server?

Here are the steps that we need to follow:

1. We have to call `run` on some object
2. The object must contain a method called `call`
3. The `call` method takes in one object and returns an array with three things:
 - Status Code
 - Headers
 - Body

 For example:

 ```ruby
class Application

  def call(one_thing)
    [200, {}, ['Hello, World']]
  end

end

my_app = Application.new
run my_app
 ```

When running this through `rackup` it will serve a page on the localhost

This call method now responds to a request from the browser.

The information that is received by the method is in the form of a hash

But we can convert it into a more useful object by calling `Rack::Request.new(request)` on it.

```ruby
def call(env)
  req = Rack::Request.new(env)
  path = req.path
  if req.get? && path == '/'
    response_body = '<h1>Welcome Home</h1>'
  elsif req.get? && path == '/dogs'
    response_body = "<h1>Woof!!</h1>"
  end
  [200, {}, [response_body]]
end
```

### Defining HTML Files in separate files

This is an overly simple example but we would typically write out a regular HTML
page in a different file and set the response body to the file contents:

```ruby
def call(env)
  req = Rack::Request.new(env)
  path = req.path
  if req.get? && path == '/'
    response_body = File.read('/views/index.html')
  elsif req.get? && path == '/dogs'
    response_body = File.read('/views/dogs.html')
  end
  [200, {}, [response_body]]
end
```

### Response Object

Rack also has an abstraction that makes it easier to work with the response that
we are sending out, we can use it as follows.

```ruby
def call(req)
  resp = Rack::Response.new
  resp.write = response_body
  resp.finish
end
```

### Connecting the Database

What if want to add in a database of books?

The first thing that we want to do is decide what url will correspond to that table/object.
In the case of books we probably want to use `/books`.

We also want to namespace the book views within our app and make a directory for
`books` and within it have an `index.html`, `show.html`, etc.

Then we can add that path to our call method:

```ruby
def call(env)
  if req.get? && path == '/books'
    response_body = File.read('/views/books/index.html')
  end
end
```

### ERB

What if we wanted to manipulate our html files with ruby?

We can use something called `erb` which stands for Embedded Ruby.

Let's change the name of the file to `/views//books/index.html.erb`, this will
signify that we want to evaluate the ruby in our code.

We can write something like:

`<%= 1 + 1 %>`

which will evaluate to 2 in Ruby.

```ruby
def call(env)
if req.get? && path == '/books'
  response_body = File.read('/views/books/index.html.erb')
end
```

If we try to render this view it will just give us back the actual statement.
So we need to create a new `ERB` instance in order to have erb evaluate it and
return a string to our call method.

```ruby
file = File.read('/views/books/index.html.erb')
erb_instance = ERB.new(file)
result = erb_instance.result
response.write(result)
```

The `#result` method takes in all of the code that is being passed in and evaluates
it and replaces the ruby with the strings that they evaluate to.

Now we can render that string in our call method.

### Getting things from the model into the view

So first we need to get all the books from the Model

In our call method, let's define an instance variable `@books` and set it `Book.all`,
this will store all of our books inside that variable.

We also need to pass along the variable to the `#result` method of the erb_instance
and we can do that by passing in `binding` and then we can use the instance variable in the view.

```erb
<ul>
<% @books.each do |book| %>
  <li><%= <h2>book.title</h2>%> by <%= <h2>book.author.name</h2> %></li>
<% end %>
</ul>
```

### [Binding](https://ruby-doc.org/core-2.2.0/Binding.html)

binding is a variable that contains the entire scope of the application at a
certain point including the `@books` variable.


### Getting a single Object by id

What is a user wants to retrieve a particular book by id?

We can send the id by query string parameters.
`?id=8&name=doug`

How would we get this to our Ruby code?

We can manually convert it by iterating through each key value pair and converting
that to a hash.

Rack does this for us automatically.

we can write `@book = Book.find(req.params[:id])` and this will look up the id that
was passed along in the query string.

In the view we can render the book's details:

And link to the individual books from the index page:

```ruby
@books.each do |book|
  <a href=/books?id=<%= book.id %>><%= book.title %></a>
end
```

### Refactoring our server

We now have code that is very repetitious. For every different class we are getting the
template from the views folder

`template = File.open('views/model/index.html')`

We are then creating a new erb instance with the template

`erb_instance = ERB.new(template)`

Then we are running ERB to interpret each template

`result = erb_instance.results(binding)`

Then we are adding the result to the response

`resp.write(result)`

And then we close and return the repsonse

`resp.finish`

There is a lot of repetitious code here.

Let's define a `#render` method to wrap all this functionality:

```ruby
def render(file_path)
  resp = Rack::Review.new
  emplate = File.open(file_path)
  erb_instance = ERB.new(template)
  result = erb_instance.results(binding)
  resp.write(result)
  resp.finish
end
```
