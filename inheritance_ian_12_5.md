# Inheritance
## By Ian

### What is Inheritance and why do we need it?

Many times while we are writing classes we start to realize that we are repeating a lot of code for different classes. For example if we are defining different types of people, like doctor, teacher, etc.
They all have a name and also other attributes in common.

For this we can define a super class.

Let's we have an `Iguana` class:

```ruby
class Iguana
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

igor = Iguana.new('Igor')
```
Now if we wanted to create a class that includes `Iguana`s and other pets, like Dog, Cat, etc. we can define a superclass of `Pet`

```ruby
class Pet
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end
```

Now we can create many types of `Pet`s by using inheritance to add all the attributes of the `Pet` superclass.

```ruby
class Iguana < Pet

end

class Dog < Pet

end

class Cat < Pet

end
```

### Creating custom attributes

While we have all the attributes from the superclass, we can still define custom attributes that are not shared by other subclasses of the superclass.

```ruby
class Iguana < Pet
  def be_smelly
    "Pee-ew!"
  end
end

class Dog < Pet
  def bark
    "Woof!!"
  end
end

class Cat < Pet
  def meow
    "meow"
  end
end
```

### Order of method calls

When Ruby calls a method for an object, it calls the lowest definition which means that it will look within the subclass first, then if it doesn't find it, it will continue to search in the superclass chain until it finds it.

### Creating a console file

Require all the files that you want to have access to and then call pry:
`Pry.start`

### Defining custom initialization

What if we want to initialize a subclass with a custom set of attributes like an `Iguana` with `@smelly` set to `true`

```ruby
class Iguana < Pet
  def initialize
    @smelly = true
  end
end
```

That will be a problem because we are passing the name and owner when we initialize it and currently it doesn't accept any arguments.


We would have to do somthing like this:

```ruby
class Iguana < Pet
  def initialize(name, owner, smelly)
    super(name, owner)
    @smelly = true
  end
end
```

What this will do it call the superclass initialize method with the arguments that are defined there and then add the custom attributes that we need in the subclass.

### Creating an Environment

We can create an environment in a new file `environment.rb` and include all our files there.

### Refactoring

Don't refactor until you see the duplication at least 3 times.
Sometimes duplication is better than unnecessary abstraction.

### Modules

We can define a module which is like a class but only for keeping methods that we want to include in certain classes. For example:

If let's say we wanted to create a method to save a certain class and adding it to an `ALL` class variable

```ruby
class Genre
  ALL = []

  def save
    ALL << self
  end

  def self.all
    ALL
  end
end
```

We would have to do this again for every class that we want to have this functionality.

Instead we can create a module called `Memorable`

```ruby
module Memorable
  def save
    ALL << self
  end
end
```

and then we can include this module in any class that we want to have this functionality.

```ruby
class Genre
  include Memorable
end
```

The only problem is that the variable `ALL` is not defined for the class that is including the module.

So what we can do is call the `self.class.all` method to get the class variable of ALL:

```ruby
module Memorable
  def save
    self.class.all << self
  end
end
```

### Extending Modules

What if we wanted to define a class method inside a module. The problem we have is that we normally define a class method with the `self.method` syntax, but here, `self` refers to the module, not the class, so what can we do?

First we have to split the module into `InstanceMethods` and `ClassMethods`.

We can use the `extend` keyword on the module to add class methods.

Within the `ClassMethods` we can use namespacing to access the classes attibutes, so in this example, we can define `self::ALL` then we can refer to the all by `self.all` by defining a method of self.all in the module:

```ruby
def self.all
  self::ALL
end
```

Now we can do whatever we want by calling `self.all`!

### Namespacing inside a module

We saw that we can define different modules for instance and class methods.
In order to make it more organized we can actually create a namespace within the module for each of the different modules we want to define.

```ruby
module Memorable

  module InstanceMethods
    # methods for instance
  end

  module ClassMethods
    # methods for class
  end

end
```

Now we can include the class and instance methods in the class that we need them:

```ruby
class Genre
  include Memorable::InstanceMethods
  extend Memorable::ClassMethods
end
```

### Questions that I have:
- What's the difference between include and extend?
