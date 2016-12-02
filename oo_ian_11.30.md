## Object Oriented Programming with Ruby
### Lecture by Ian Candy

#### Everything in Ruby is an Object

Which means that every variable or peice of data is actually an object an object.
When we call a method in Ruby, what we are doing is really sending a message to an object.

For Example

```ruby
1.odd?

# Is actually
1.send(:odd?)

book = {title: "Programming Ruby"}

book[:title]

# Is actually
book.[](:title)

```

This example shows that most operations are actually just shorthands for methods that are defined for that object by Ruby.  

#### Defining our own objects

But we are trying to show how to abstract a real world object in code form.

```ruby
book = Object.new

def book.title
	'Programming Ruby'
end

def book.authors
	['Matz', 'David Black']
end

def book.author_names
	book.authors.join(" and ")
end
```

The problem is that if we want to create a new book we need to add in all the information again.  

```ruby
Book = Class.new do

	def title
		# local
		title
		# global
		$title
		# instance
		@title
	end

	def title=(title)
		# local variable == bad
		title = title
		# global variable == bad
		$title = title
		# instance variable == the shiznits
		@title
	end

	def authors

	end

	def author_names
	end

end

book = Book.new
book2 = Book.new

```

So we can set the `title` variable by using the title class, using a local variable.

But when we do that, when we try to access the variable the class will break because we cannot access a variable that is outside the scope of the setter method.

So we can try using a global variable by adding a `$` before the variable, but the problem with this is that if we create more than one instance of this class and set the title of the second instance to something different than the first, it will change that global variable, and the first instance title is also using the same global variable, therefore it will be equal to the title that we set for the second instance.


#### The setter method

#### How do accessors work?

An attr_accessor is a ruby built in method for all objects that replaces the getter and setter methods for a class. So instead of defining a getter and setter the long way, we can just use the attr_accessorand it will define those methods for us.

For example in order to define getter and setter we used this code:

```ruby
def title
	@title
end

def title=(title)
	@title = title
end
```

This one line replaces all of that:

```ruby
attr_accessor :title
```

<center>[sweeet](images/sweeet.gif "sweet")</center>!
<center>*Sweeet!*</center>

#### Symbol vs String

A symbol is the same as a string with the difference that it cannot be created more that once and it starts with a `:`. Since we are only using title once in our class it makes sense to use a symbol.

#### Initialize

The initialize method is a method that the Class runs when new is called.

#### Class local methods



#### Self
