# Real World Project
# Command Line Interface - Get Books From API
## By Ian Candy

### Setting up our app

We start by creating folders named `bin`, `lib`, and `config`
Then we create an empty Gemfile and add the following:

```ruby
source "https://rubygems.org"

gem "rest-client"
gem "pry"
```

In the environment file we will run Bundler:

```ruby
require 'bundler'
Bundler.require
require 'json'

require_relative '../lib/book'
```

We require bundler gem first then we run the Bundler which will download and install the gems in the Gemfile. Then we require the `json` module and the class file for our `Book`

Next we will define our runner in `bin/run.rb`

```ruby
require_relative '../config/environment'
require_relative '../lib/book_it_cli.rb'

puts 'Running the application'
BookItCLI.new.call
```

### Adapter Design Pattern

### Comments are lies waiting to happen

### Project Requirements
- Must hit an API
- Must be an open API
- Suggestions:
  - NYC Open Data
  - Public Safety API
