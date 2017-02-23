# Data Structures - 2.23.17
## By Ian


### Big O

This is an expression of how complex a function is, and how many more operations it has to do when you increase the size of the input.

O(1) is constant and doesn't change at all
O(n) increases n amount when given n amount of inputs
O(n ** 2) increases the amount of operations by the square of n

A rule of thumb to find the Big O is how many nested loop there are in the function.

### Arrays

In order to make an array we need to allocate a space in memory for each element.

This can be done very efficiently using multiples of 8 to record the address.

```ruby
[_]
[_]
[_]
[_]
[_]
[_]
[_] # address: 124
[_"C"_] # address: 116
[_"B"_] # address: 108 - 8 bits - in order
[_"A"_] # address: 100 - 8 bits - in order


array = ['A', 'B', 'C']

array[0] # -> Will look in address 100
array[1] # -> Will look in address 108

array[n] # -> Will look in address 100 + (8 * n)
```
This has a Big O of O(1).

But what if we wanted to get rid of the first element of the array?

We would have to move every single element down a space in memory.
```ruby
[_]
[_] # address: 124
[_"C"_] # address: 116
[_"B"_] # address: 108 - 8 bits - in order
[_"A"_] # address: 100 - 8 bits - in order


array = ['A', 'B', 'C']

array.shift # -> ['B', 'C']

[_] # address: 124
[__] # address: 116
[_"C"_] # address: 108 - 8 bits - in order
[_"B"_] # address: 100 - 8 bits - in order

```
In order to do this we would have to remove the first element from memory and then reassign all the other elements to a memory address that is 8 less than it was previously.

This has a Big O of O(n).

### Linked List

We can also implement an array by randomly assigning the memory address but storing a pointer to the next element in the array, the first node will have a attribute called head.

In order to add an element to the beginning, all we have to do is add another node in memory and add a pointer to the current head, and then just make this node the current head.
