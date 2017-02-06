# Building an API with Rails - 2.3.17
## By Antoin

### What's an API?

An API is a way for a server to respond to request with pure data. An API could be exactly the same as a webpage, but without presenting/rendering the data.

### CORS

Most APIs are being called on by the same domain, either from the back-end or the front-end of the app. However, if an API author would like to make the api available to other developers they can enable CORS on their API which is just a header that tells the browser not to block it.

## Project TuneAPI

### Namespacing routes

In the routes we want to make sure that we keep our versions separate from each other so that changes to one version don't break earlier versions.

```ruby
scope module: 'api' do  # lets use route to contollers without explicity including it in the url
  namespace :v1 do

  end
end
```

### Serving up JSON

We can return json instead of html simply by rendering JSON

```ruby
def index
  @albums = Album.all
  render json: @albums
end
```
