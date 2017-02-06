# React State 2.1.17
## By Ian

As a demonstration we will build an app that contains a search form that automatically displays a gif on every letter that's typed.

The components that we want to define to start with are:

- A search Form
- A Gif Displayer(GifShow)
- A Gif App to wrap both of those and keep the unidirectional flow

### Exercise

Two components Navbar and App

```js
import React from 'react'
import ReactDOM from 'react-dom'


// Class based Component
// This is for
// class Navbar extends React.Component {
//  render() {
//    return (
//      <nav class="navbar">{this.props.title} </nav>
//    )
//  }
// }

// Functional Component
// This is for presentational elements
// not for elements that are going to change
// We should make all components this way until
// they need more functionality
var NavBar = function(props){
  return (
    <nav className="navbar navbar-default">
      <a href="#" className="navbar-logo">{ props.header }</a>
    </nav>
  )
}

export default Navbar


var App = () => {
  // React.createElement(NavBar, {header: 'Ruby Duby Doo'})
  return (
    <div>
    // We can pass in props using the attribute syntax of HTML
      < NavBar header='Hey Ruby Duby Doo' />
      < GifPage />
    </div>
  )
}

ReactDOM.render(App, document.findById('container'))
```

### State

Up until now we can only pass in props manually, but what if we want to change the props based on something the user does or some other event?

We have to build a component with a sense of state.

First of all we have to change our component to a class based Component.

```js
class SearchForm extends React.Component {
  render(
    return (
      <div>
        <form className="col-md-4">
          <input type="text" />
          <input type="submit" />
        </form>
      </div>
    )
  )
}
```

In order to add the state we need to overwrite the constructor method of the object. In our case we want to add a query field to the state:

```js
constructor(){
  super()
  this.state = {query: ''}
}
```

Then we can bind this state to a component like this:

```js
<input type="text" value={this.state.query} onChange={ (event) => {
    this.setState({query: event.target.value})
  }} />
```
