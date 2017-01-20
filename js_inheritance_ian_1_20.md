# Javascript Inheritance
## By Ian

### Ruby inheritance

In Ruby inheritance works in a straightforward way:

```ruby
class Person
  attr_accessor :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end
end

class Artist < Person

end
```
Now the child class has the attributes and methods of the parent class.

### Javascript Inheritance AKA Prototypes

In JS things are slightly different. If we wanted to create an artist such as Kanye West we would do it without inheritance like this:

### `this`

```js
var kanye = {
  firstName: "Kanye",
  lastName: "West",
  fullName: function(){
    return `${this.firstName} ${this.lastName}`
  }
}

var jay_z = {
  firstName: "Sean",
  lastName: "Carter",
  fullName: function(){
    return `${this.firstName} ${this.lastName}`
  }
}
```

If we had to do this with every artist we would be typing forever and if we wanted to change something it would take several years.

We can create a function that constructs new objects for us

So lets create the `Person` constructor:

```js
function Person(firstName, lastName){
  this.firstName = firstName
  this.lastName = lastName
}

var kanye = new Person('Kanye', 'West')
// kanye == { firstName: 'Kanye', lastName: 'West' }
```

```
// This is what the new keyword is doing behind the scenes
function MyNewPerson(constructor, firstName, lastName){
  var object = {}
  object.initialize = constructor // function that creates the new object
  object.initialize(firstName, lastName)
  return object
}
```

Example using a Book Model:

```js
// Book Class with unique Authors and Titles
function Book(author, title){
  this.author = author
  this.title = title
  this.description = function(){
    return `${this.title} by ${this.author}`
  }
}

var harryPotter = new Book('J.K Rowling', 'Harry Potter')
```

Each property is being initialized by the Book function and when its done it returns a new object with those properties.

Essentially this is the same as class inheritance in Ruby because we can return many instances of the object.

But what about the function, why should we have a new one every time if it's the same for every book?

### Prototypes

What we can do is add the description function to the prototype of the `Book` object and what will happen is that all instances will inherit from the prototype.

In fact there are already many functions that are defined already like `toString()` that are shared between all objects, this is because the prototype of `prototype` is the `Object` which defines those functions.

We can do this in practice like this:

```js
function Book(author, title){
  this.author = author
  this.title = title
}

Book.prototype.description = function(){
  return `${this.title} by ${this.author}`
}

var harryPotter = new Book('J.K Rowling', 'Harry Potter')
```

Let's make another object:

```js
function Bicycle(brand, color){
  this.brand = brand
  this.color = color
}

Bicycle.prototype.wheels = 2
Bicycle.prototype.takeARide = function () {
  console.log("Weeeeee!")
};
```

### Patterns and Anti-Patterns

A pattern is a solution to a problem that is optimal and should be used, an anti-pattern is a solution to a problem, but the solution is likely to have bad side-effects or would be hard to understand and use later.
