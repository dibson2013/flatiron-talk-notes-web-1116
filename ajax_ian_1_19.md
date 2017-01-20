# AJAX/XHR - 1.19.17
## By Ian

### What is AJAX?

Ajax is a way to send requests and receive responses within a given web page without having to do anything to the page. We can get the response and then do whatever we want with it, without the page changing.

### [Code-Along](/code-alongs/21_ajax-lecture-web-1116)

We will create a project that utilizes the AJAX pattern

### package.json & npm & node_modules

`package.json` is our dependency manager file and npm reads this file and decides which libraries (or modules) that we want include and which version, and npm created a folder in our project called `node_modules` which includes the modules that we specified.

## Setting up a basic request

```js
const URL = "https://www.googleapis.com/books/v1/volumes?q=ruby+programming"

let request = new XMLHttpRequest()

request.open('GET', URL, true)

request.onload = function(){
  let data = JSON.parse(this.response)
  console.log(data)
}

request.send()
console.log('sending the request')
```

We are creating a new request object that makes a call to the url that we defined and firing a callback that logs it to the console.

What's important is that we are receiving JSON from the server and we are parsing the JSON into a Javascript object that is easier to work with. We should see an object appear in the console. Also important to note is that the log that we set after the `request.send()` will appear before the object. This is because of the asynchronous nature of the request. We only want to fire the onload function after the data loads, but in the meantime we will continue going down the page and executing the code.

There are a number of different ways to structure AJAX requests.
[Axios](https://github.com/mzabriskie/axios) is one, and [fetch](https://github.com/github/fetch) is another.


```js
//
// let request = new XMLHttpRequest()
//
// request.open('GET', URL, true)
//
// request.onload = function(){
//   let data = JSON.parse(this.response)
//   console.log(data)
// }
//
// request.send()
// console.log('sending the request')
$(document).ready(addFormEventHandler)

function addFormEventHandler(){
  $('form#book-form').submit(formSubmitHandler)
}

function formSubmitHandler(event){
  event.preventDefault()
  findAndRenderBooks()
}

function findAndRenderBooks(){
  const BASE_URL = "https://www.googleapis.com/books/v1/volumes?q="
  // Find user search query and interpolate into BaseURL
  $input = $('input#query')
  var user_query = $input.val()
  $input.val('')
  parsed_user_query = user_query.replace(/\s/g, '+')
  // Fire request
  $.ajax({
    url: BASE_URL + user_query,
    success: renderBooks
  })
}

function renderBooks(data){
  // Handle response
  let bookList = $('ul#books')
  bookList.html('')
  data.items.forEach(function(book){
    let title = book.volumeInfo.title
    let description = book.volumeInfo.description
    description = format_description(description)
    bookList.append(`<li class="collection-item"><h5>${title}</h5><p>${description}</p></li>`)
  })
}

function format_description(description){
  if (description){
    return description.substring(0, 80) + '...'
  } else {
    return " "
  }
}

```

Whatever.
