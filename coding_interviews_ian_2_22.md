# Technical Interview Prep - 2.22.17
## By Ian Candy

### The Opening

When the problem is presented, the interviewer is expecting some questions about the problem. For example when asked to sort a list, some questions might be:

- What data types will be in the list
- What are we sorting by
- What if the list is empty
- What should I return
- Should I modify the original elements
- What should I do with weird inputs

The interviewer is waiting for these questions so that you don't struggle with a misconception of the problem.

Another thing to do before going over the approach is to rephrase the problem in your own words. Make sure that the interviewer agrees with your phrasing of the problem, then you can move on, otherwise clarify your misconceptions and then rephrase again.

### Problem Solving

### Coding

### Recursion

A recursion is a function that calls on itself.

```ruby
def sum_up_to_four
  1 + 2 + 3 + 4
end

# This can really be written like this:
def sum_up_to_four
  sum_up_to_three + 4
end


def sum_up_to_three
  1 + 2 + 3
end

# And that can written like this:
def sum_up_to_three
  sum_up_to_two + 3
end

def sum_up_to_two
  1 + 2
end

# That can be written like this:
def sum_up_to_two
  sum_up_to_one + 2
end

def sum_up_to_one
  1
end
```

What is happening is that we are essentially calling the same method with another argument we can do this in one function by recursion.

```ruby
def sum_up_to(number)
  if number <= 1
    1
  else
    sum_up_to(number - 1) + number
  end
end

sum_up_to(4)
sum_up_to(3) + 4
sum_up_to(2) + 3 + 4
sum_up_to(1) + 2 + 3 + 4

```

Whats happening is that our master function is calling itself with a new argument and adding the number to it.

```ruby
# return sum of all elements in a given array
def sum_array(array)
  if array.length == 1
    array[0]
  else
    array.pop + sum_array(array)
  end
end

array = [1, 2, 3, 4]

sum_array([1, 2, 3, 4])
sum_array([1, 2, 3]) + 4
sum_array([1, 2]) + 3 + 4
sum_array([1]) + 2 + 3 + 4
1 + 2 + 3 + 4

# Non-destructive
def sum_array(array)
  if array.length == 1
    array.first
  else
    array.last + sum_array(array[0..-2])
  end
end

puts sum_array([1, 2, 3, 4])
```

```js
function sumArray(array){
  if (array.length == 1){
    return array[0]
  } else {
    return parseInt(array.slice(array.length - 1)) + sumArray(array.slice(0, array.length - 1))
  }
}

sumArray([1, 2, 3, 4])
```
