# REST - 12.19.16
## By Ian Candy

### What is REST?

REST was theorized by Roy Fielding and basically means that the route that is used to access or change a resource should accurately reflect what it's doing.


### Authors Resource


1. GET '/authors' -> Shows Index
2. POST '/authors' -> Creates a new author
3. GET '/authors/:id' -> Show one author
3. PUT '/authors/:id' -> Update an author
4. DELETE '/authors/:id' -> Delete an author

```ruby
AuthorsController < ApplicationController
  def index
    @books = Book.all
    erb :index
  end

  def new
    erb :new
  end

  def create
    @book = Book.create(params[book])
    redirect to show
  end

  def show
    @book = Book.find(params[:id])
    erb :show
  end

  def update
    @book = Book.find(params[:id])
  end

  def delete
    @book = Book.find(params[:id])
  end
end
```
