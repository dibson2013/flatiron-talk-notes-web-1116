# Closures - 1.18.17
## By Ian

### What is a closure?

We can return a function from a function in javascript:

```js
function minimumAgeChecker(minimumDrinkingAge){
  var min = minimumDrinkingAge

  return function(age) {
    return age >= min
  }
}

const canDrinkInUsa = minimumAgeChecker(21) // This will define canDrinkInUsa as a function that checks the input against 21 which we just set as an outer scoped variable
const canDrinkInCanada = minimumAgeChecker(19) // This will check against 19
const canDrinkInQuebec = minimumAgeChecker(18)
const canDrinkInIreland = minimumAgeChecker(12)


function greetingCreator(greeting){
  return function(name){
    return `${greeting}, ${name}`
  }
}

const greetInUSA = greetingCreator("Hello")
greetInUSA("Franco") // => "Hello, Franco"
```

What is happening here is that when we return the function into the variable it inherits the scope of the outer function that it's in and therefore can use the variable greeting. Now we can call the function that we defined with any argument and it will return with a custom greeting.

### Closures accessing functions

```js
function minimumAgeChecker(minimum){
  function isOldEnough(age){
    return age >= minimum
  }

  return function(age){
    return isOldEnough(age)
  }
}

const canDrinkInUsa = minimumAgeChecker(21)
```

### Returning closures inside Objects

```js
function minimumAgeChecker(min){
  function isOldEnough(age){
    return age >= min
  }

  function notOldEnough(age){
    return age < min
  }

  return function(age){
    return {
      isOldEnough: isOldEnough,
      notOldEnough: notOldEnough
      }
  }
}
```

### Syntactic Sugar for return key value pairs

To return a key value pair inside an object that are the same, we can just write the word as an argument and it will be returned as a key value pair

For example:

```js
var name = "Andrew"

var newPerson = {name}

// This will return an Object that looks like { name: "Andrew" }
```

### DOM

![Dom diagram](https://i.stack.imgur.com/h5cqC.gif)

The Document Object Model is the way our javascript interacts with the browser.

The window is the highest level scope. It contains the information about the actual browser and also the document that is being displayed at any given time.


### JQuery

[JQuery]() is a library that makes it much easier to find things in the DOM and attach events to them.

#### AJAX

JQuery also makes it easy to make AJAX requests, which is just requests to the server without re-rendering the page

#### Selecting and manipulating elements

We can select an element by using it's css selector for example: `$('h1')` will select all h1 elements on the page
we can select the first one by adding `.first()` to the end of it and get the text by adding `.text()` to the end of it, and we can even change it by passing a string to `.text("Some string")`.
`$('h1').first().text("Some string")` will change the text of the first h1 element on the page.

### Using JQuery to make a basic todo list

We have a basic HTML Document with a form that a user would input items to do

We start by adding a `.submit()` event to the form element so that we now have a handler run code every time the user hits the submit button.

By default the submit is going to make another request to our page and reload it, so we want to prevent that.

We need to set the event parameter in the handler function and call `event.preventDefault()` on it

By adding `debugger` into our code we can set a breakpoint and stop execution and in the console we can inspect our arguments.

```js
$('form#todo-form').submit(function(event){
  // find what the user inputted
  // append that to the ul in the DOM..
  // clear the input element
  var $input = $('input#todo')
  var newTodoItem = $input.val()
  if (newTodoItem.length > 0){
    $('ul#todos').append(`<li class="collection-item">${newTodoItem}</li>`)
  }
  $input.val('')
  event.preventDefault()
})
```
This will get the input value and set it as a variable, check if it has something in it and adds it to the ul then clears the input.

### document.ready()

If we load our javascript before the page loads, we are going to run into problems because javascript will nothing to work with. To fix this we can either load the script on the bottom of the page, or we can do it better by attaching the ready event to the document, which will cause the functions in our file to fire as soon as everything on our page is loaded.

We do that by adding `$(document).ready( // stuff we want to do  )`

### Refactoring

In our file we can refactor all our functions as named functions as opposed to anonymous function so that it is more readable and reusable.

```js
$(document).ready(addFormEventHandler)

function addFormEventHandler(){
  $('form#todo-form').submit(handleFormSubmit)
}

function handleFormSubmit(event){
  // find what the user inputted
  // append that to the ul in the DOM..
  // clear the input element
  var newTodoItem = getUserInput()
  appendListItem(newTodoItem)
  event.preventDefault()
}

function getUserInput(){
  var $input = $('input#todo')
  var newTodoItem = $input.val()
  $input.val('')
  return newTodoItem
}

function appendListItem(newTodoItem){
  if (newTodoItem.length > 0){
    $('ul#todos').append(`<li class="collection-item">${newTodoItem}</li>`)
  }
}
```

### Function shorthand for document.ready

As a shorthand we can pass in a named function into a plain `$()` tag and Jquery will infer that we want to run that function on document ready, so we can refactor like this:

```js
$(addFormEventHandler)
```
