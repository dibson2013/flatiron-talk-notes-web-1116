# Intro to Redux - 2.6.17
## By Ian Candy

1. What is Redux?
2. Why does Redux exist?
3. What are the principles of Redux?
4. What are the concepts/ideas/terminology of Redux?


### Basic Counter

```js
class Counter extends React.Component {
  render(){
    return (
      <div>
      <h1>0</h1>
      <button>Increment Counter</button>
      </div>
    )
  }
}
```

### Creating a store

```js
// state is stored in a plain js object
const store = {}
let state = 0

// functions to access and change our state
store.getState = function(){

}

// This will change a state
store.dispatch = function(){

}

// This will let a component listen to the state
store.subscribe = function(){

}

export default store
```

### Using the store

```js
// The store can be passed into a component as a prop

ReactDOM.render(< Counter store={store} />, document.getElementById('container'))
```
### Store Functions

```js
// functions to access and change our state
store.getState = function(){
  return state
}

// This will change a state
store.dispatch = function(action){
  if (action.type === 'INCREMENT_COUNT') {
    state = state + 1
  }
}
```

### Adding an Event Listener

We can add a click listener on a button element to call this dispatch function.

```js
<button onClick={this.props.store.dispatch}></button>
```
