# Javascript Inheritance
## By Ian Candy

### Basic Constructor

We now know how to make a basic constructor function:

```js
function Dog(name, breed){
  this.name = name
  this.breed = breed
}

Dog.prototype.bark = function(){
  return 'Woof!'
}
```

### Basic Inheritance

What if we wanted to define a constructor that inherits from Dog like a Puppy?

We can set the Puppy prototype to the Dog prototype so that it now shares functionality

```js
Puppy.prototype = Dog.prototype

Puppy.prototype.nip = function(){
  return "Sorry, I just want to play!"
}
```

But the problem is that now the Dog class shares all functionality, so that if we define a new function for puppy it is now available in the Dog class.

```js
Puppy.prototype = Object.create(Dog.prototype)

Puppy.prototype.nip = function(){
  return "Sorry, I just want to play!"
}
```

What we can do instead is set the prototype to an *instance* of the parent class which will inherit the functionality but not modify the parent prototype when we change the child's.

We also want to make the constructor for the puppy inherit the properties of the Dog and add it's own properties:

```js
function Puppy(name, breed){
  Dog.apply(this, arguments)
  this.cute = true
}
```

We use the apply function (and we could also use the call function) which will take the constructor function from Dog and set `this` to the Puppy object. The apply function will take in an array of arguments (which javascript defines for every function) and pass them into the Dog constructor function, but instead of calling on Dog, it's calling it on Puppy and constructing a new one.

### ES6 Inheritance

ES6 gives us a new and improved syntax for doing all this. We can define a `class` for Dog:

```js
class Dog{
  constructor(name, breed){
    this.name = name
    this.breed = breed
  }

  bark(){
    return "Woof!"
  }
}

class Puppy extends Dog{
  constructor(name, breed){
    super(name, breed)
    this.cute = true
  }

  nip(){
    return "Sorry, I'm just trying to play!"
  }
}
```

This will do the same thing as our code above. The super method will effectively run the code `Dog.apply(name, breed)` because that is the constructor of the parent class.
