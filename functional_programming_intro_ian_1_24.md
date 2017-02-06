# Intro to Functional Programming - 1.24.17
## By Ian Candy

### OO vs Functional

What is the difference between Object-oriented language and a Functional language

Object-Oriented

- Concerned with the state of the objects that are modeled
- contains state and behavior
- A method is only part of an object

Functional

- Concerned with behaviors over state
- Functions are constructs on their own
- contains behaviors

### Pure functions

Pure functions have 2 conditions:

1. They always return the same value for the same input
2. They don't affect the state of the program(they have no side-effects)

```js
var squareNumber = function(num){
  return num ** 2
}

var doubleNumber = function(num){
  return num * 2
}

const num = 5
const squared = squareNumber(num) // 25
const doubled = doubleNumber(squared) // 50


// This is not a pure function
// because it will return a different value based on the minimum
// that is outside the scope of the function
var minimum = 21

function canDrink(age){
  return age >= minimum
}


// This is a pure function because it doesn't rely on anything

function canDrink(){
  let minimum = 21
  return age >= minimum
}

// This is not a pure function because it changes something outside of it

var line = []
function takeANumber(line, name){
  line.push(name)
}

// This is a pure function because it does not change line

function takeANumber(line, name){
  return [...line, name]
}
```

### Controlling state in a functional program

How do we control the state if we can't change anything from within functions?

```js
const state = {
  line: []
}

function takeANumber(line, opts){
  return [...line, opts.name]
}

function serveCustomer(line){
  return line.slice(1)
}

function updateLine(line, opts, callback){
  state.line = callback(line, opts)
}

updateLine(state.line, {name: 'Franco'}, takeANumber) // will add a customer with the name Franco to the line that is in the state
updateLine(state.line, {}, serveCustomer) // Will remove the first customer
```

In the above example we are abstracting out the specific functions that act on the state and making them into pure functions, and putting all the state changes into one abstract function called updateLine which takes a different callback and options and changes the state based on those arguments.


### Using callbacks

We can create a forEach method using the following pattern:

```js
function myForEach(array, callback){
  for(let i = 0, l = array.length;i < l; i++){
    callback(array[i], i)
  }
}
```

## Arrow function syntactic sugar

```js
class Cat {

  constructor(){
    this.kittens = ["Marley", "Grouchy", "Billy" ]
  }

  feedCats(){
    // iterate over our list of kittens and for each one, call our 'feedKitten' function
    this.kittens.forEach( function(kitten) => {
      return this.feedKitten(kitten)
    })
  }

  feedKitten(kitten){
    console.log(`Feeding ${kitten}`)
  }
}
```

In the above code we have a problem. In the `feedCats()` function the `this` keyword does not refer to the object that is calling it anymore and will result in bugs.

We can call the function with a `.bind(this)` at the end to pass along the `this` value, but there is a better way.

```js
feedCats(){
  // iterate over our list of kittens and for each one, call our 'feedKitten' function
  this.kittens.forEach( (kitten) => {
    this.feedKitten(kitten)
  })
}
```

This is the basic usage of the arrow function which implicitly binds the `this` value, besides for being prettier.

### Leaving out the parenthesis

```js
feedCats(){
  // iterate over our list of kittens and for each one, call our 'feedKitten' function
  this.kittens.forEach( kitten => {
    return this.feedKitten(kitten)
  })
}
```

Who wants parenthesis anyways?


### Implicit Returns

We can even leave out the return keyword and we will get implicit returns.

```js
feedCats(){
  // iterate over our list of kittens and for each one, call our 'feedKitten' function
  this.kittens.forEach( kitten => this.feedKitten(kitten) )
}
```

The only conditions are that there should be no brackets around the return value.
