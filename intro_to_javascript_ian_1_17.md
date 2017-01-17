# Intro to Javascript
## By Ian

### Preface

Before learning a new language we should be aware of 3 different aspects of the subject:

- programmatic thinking
- syntax
- design patterns

### History of Javascript

[Wikipedia](https://en.wikipedia.org/wiki/JavaScript)

Brendan Eich created Javascript in 10 days in 1994. He built it for the Mosaic Browser.

### XHTML

Microsoft

### ECMA Script


### Node

[Wikipedia](https://en.wikipedia.org/wiki/Node.js)

### Datatypes

There are 5 primitive datatypes in JS:

```javascript
var number = 5;
var string = "Hello";
var boolean = true;
var emptyValue = null;
// You can declare a variable without assigning it
var name; // This will be undefined which is another primitive datatype

const myDog = "Fido" // Cannot be reassigned, will result in an error


if(false){
  let myName = 'Moron' // Defines a variable only for the local scope
}

```

### Semicolons

Semicolons in javascript are optional, and are automatically inserted by the interpreter; most engineers agree that writing your programs without them are faster and better.


### Arrays and Objects

Arrays work pretty much the same way as they do in Ruby

```js
var teachers = ['Ian', 'Tracy', 'JJ', 'Antoin']
console.log(teachers.length)

// JS objects behave a lot like hashes
var teacher = {
  name: "Ian",
  beard: true
}
// We can access properties using dot notation
console.log(teacher.name)

// When we want to dynamically change the key we have to use bracket notation
var property = prompt('Enter the property you are looking up')
console.log(teacher[property])

```

### Hoisting

Whenever we define a variable or function javascript automatically pushes it all the way to the top of the scope and makes it available to any part of that scope.

#### Variables:

```js
console.log(cat)

var cat = "Garfield"
```
This will output undefined because the declaration of the variable gets hoisted but the assignment does not.

#### Functions:

```js
sayHi()

function sayHi {
  console.log('Hi')
}
// This would output 'Hi'
```

Expressions do not get hoisted:

```js
sayHi()

var sayHi = function(){
  console.log('Hi')
}

// This will result in an error
```

Arrow function syntax is considered an expression and is not hoisted:

```js
sayHi()

var sayHi = () => {
  console.log('Hi')
}

// Nope
```

[Expressions vs Declaration](https://www.sitepoint.com/function-expressions-vs-declarations/)

### Function Scope

Functions inherit the scope that they are defined in, therefore they have access to the variables that are defined in the scope above them.

```js
var cat = "Heathcliff"

function sayHelloToHeathcliff(){
  console.log(cat)
}
```

So this function has access to the variables that are out side of it's scope.

Also if variable are not declared with the var keyword, the assignment will look up the scope chain and will use that definition.


```js
var cat = 'Heathcliff'

function sayHello(){
  cat = "Garfield"
  console.log(`Hi ${cat}`)
}

sayHello()

console.log(cat)
```

This will output 'Garfield' because the function is reassigning the outer variable.

This function can also create a variable in the global scope, which is accessible anywhere, if the variable was not defined yet in any higher scope:

```js
function sayHello(){
  cat = 'Garfield'
  console.log(`Hello, ${cat}`)
}

console.log(cat)

// This will log "Garfield" because it is now a global variable.
```

### Callbacks

Because functions are objects, you can pass them into other functions to be called later. This is called a 'callback'

```js
function sayHelloAndDoSomething(callback){
  console.log('Hello')
  callback()
}

var myCallback(){
  console.log("Doing More Stuff")
}

sayHelloAndDoSomething(myCallback)
```

We can also define an anonymous function instead of referencing a named function:

```js
function sayHelloAndDoSomething(callback){
  console.log('Hello')
  callback()
}

sayHelloAndDoSomething(function(){console.log("This is anonymouse")})
```
