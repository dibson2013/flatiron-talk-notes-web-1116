# Cookies and Sessions- 1.5.17
## By Ian

### What is a cookie?

  - Information that is persisted to the browser
  - Server instructs the client to send the information with each request
  - Different types of cookies depending on what you need to do
  - The local file serializes the key value pairs
  - "id=9&name=Ian"
  - Rails parses the cookie file and turns it into a hash and saves it in session store
  - `cookies[:analytics_id] = "1234"`

### What's the difference between a cookie and a session?
  - Sessions are specific types of cookies
  - Sessions are stored on the server
  - Sessions are encrypted


### Login Lab Review

In the request is a hash called cookies, within that cookies hash is a key for the
session that was set by the server and a random string as a value.

Our rails app will automatically access this cookies part of the request and get
the session from it.

[Rails Guides](http://guides.rubyonrails.org/action_controller_overview.html#session)

### Redirects and renders

Rails does not allow two redirects or renders in the same action, therefore
we need to make sure that either have the redirect at the end of the method which
will override the implicit render call or user redirect and return
