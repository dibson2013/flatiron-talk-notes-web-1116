# Intro to React
## By Ian Candy

### What are Components?

We can think of component as bundles of elements that are reused throughout our app with small differences in the data that is displayed in each case for example, a nav bar that changes based on a logged in user.

### React

React is a library that was developed by Facebook for the purpose of speeding up the rendering that happens on a web page. The problem that web developers traditionally had was that getting through the DOM and manipulating it was very slow for various reasons. The solution that React offers is that it created a whole new DOM on it's own called the Virtual DOM that is much faster and easier to work with. When it has changes to it, it makes specific changes to the actual DOM much quicker.


### Creating elements

```js
const myDiv = React.createElement('div', {}, 'Hello World')
```

The arguments that the createElement takes in is a string with the tag name, an object with attributes, and the contents of the tag that we defined.

```js
ReactDOM.render(myDiv, document.getElementById('main'))
```

In the second argument we can pass in properties of the object like className or id:

```js
const myDiv = React.createElement('div', { className: 'ruby-do', id: 'title' }, 'Hello World')
```

The third argument is the child or children of the parent tag we defined in the first argument. In the above case, the string `"hello world"` is the child, but we can easily pass other created elements in as well.

```js
const myDiv = React.createElement('div', {}, React.createElement('p', {} , "It was a dark and stormy night"))
```

### Functional Components

The problem with the above is that we cannot reuse these elements.

```js
// We create an array of javascript objects with properties
const books = [{intro: "It was the best of times, it was the worst of times",
                      outro: 'Tis a far far better thing'},
               {intro: 'Call me Ishmael', outro: 'The End'},
               {intro: "In a galaxy far far away", outro: "Noooo!"}]

// this function takes the array of objects and creates a new React element
// for each element in the array by mapping through and calling Book() on each one
function BookList(props) {
  return React.createElement('div', {}, props.books.map(book => {
    return Book(book)
  }))
}

// This is the actual constructor function that takes in an object
// and creates a p tag for each one.
function Book(props){
  return React.createElement('div', {}, [
    React.createElement('p', {key: 0}, props.intro),
    React.createElement('p', {key: 1}, props.outro)
  ]
  )
}

// This is where we add all of our elements to the page
// We pass in an object with properties
// In this case we define the books property as the array of book objects
// we created earlier
ReactDOM.render(BookList({books: books}), document.getElementById('main'))
```

### Babel

We include babel in our react project in order to transpile our react code into code that all browsers can understand.

### Webpack

Webpack is a dependency manager. Basically it takes all of the files and modules that our app contains and bundles them together into one file.

In order to actually use something from our modules, we need to actually import it into our file:

```js
import React from 'react'
import ReactDOM from 'react-dom'
```

We can now use React in our project without including it in the html.

### Defining Modules and including them

We can define and include our own modules by creating a new file and using the keyword `export default` to return something, it could be a function or a value. Then we use the import syntax above to include the exported object.

### JSX

JSX is a language that allows us to write HTML tags and Babel parses through those html tags and transpiles the code into React createElement statement.
