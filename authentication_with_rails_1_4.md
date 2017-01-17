# Authenticating Users - 1.4.17
## By Ian

### Adding Users

We are working on our Twitter clone, and so far we have a form for a new
Tweet which allows anybody to create a new Tweet and put in any user id.

But this is bad because we only want one user to be able to create a new tweet for that user id, also we don't want to have to put in the user_id every time, we just want our app to know which user is logged in.

### Authentication

How will we know who a user is? We can ask a user what their name is, but
how do we they are telling the truth? We can set a password for the user
and then ask the user for it each time and this is what we do. But, we don't
want this sensitive information being stored the way it is, because if someone gets access to our server, they can see all passwords and compromise every account.

### Encryption - Salting and Hashing

In order to prevent the information from being vulnerable, we do something that makes it almost impossible for someone to know the password, we encrypt it. So we do 2 things, we [Salt](https://en.wikipedia.org/wiki/Salt_(cryptography)) the password, which means we add random data to it.

Then we [Hash](https://en.wikipedia.org/wiki/Cryptographic_hash_function) it, which means that we substitute each character for a different one.

### bcrypt gem

We add the gem like this:

```ruby
gem 'bcrypt'
```

We need to add `has_secure_password` and a `password_digest` field to our User model and viola!, we have access to the method `password=` and bcrypt will automatically encrypt whatever string we get and store it as a hash in `password_digest`. We also get the method `authenticate` which compares a string with the hashed password.

When a user wants to log in they can enter the password and we can call `authenticate` on that and if it's true we get back the `User` object. Neat.

### Cookies

We know that the web is stateless, which means each request and response happens in a vacuum, unaware of any other requests or responses. So how do we know who a user is after they leave the login page?

A cookie is simply a file that is stored on the client side with some info in it. We need to set it from our application, then we can read from the cookie while the user is logged in and destroy the cookie when the user logs out.

We can create a `CookiesController` and add something to it, which will add it to the users cookies.

```ruby
def name
  cookies[:name] = params[:name]
end
```

### Sessions

Rails gives us an easy way to add a user session to the users browser and we have a sessions hash within the params

We can create a SessionsController to create new sessions and set these cookies.

```ruby
class SessionsController
  def new
    # Render a login form
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to tweets_path
    else
      flash[:notice] = "Wrong Username/Password"
      redirect_to '/login'
    end
  end

  def destroy
    session[user_id] = nil
    flash[:notice] = "Logged Out"
    redirect_to 'login'
  end
end
```

Now we can set the user to the user_id in the session cookie.

```ruby
@user = User.find(session[:user_id])
```

We can now display the username everywhere in our app by including `@user.username` in the layout file.

But, what if the user does not exist? This will break our app.

So we should define a helper method in our ApplicationController called
`authenticate_user` which will return the user if they are logged in.

```ruby
def logged_in?
  !!session[:user_id]
end

def current_user
  @current_user ||= User.find_by(username: session[:user_id])
end
```


### Helper Method

Helper methods are methods that we want to define for all instances of a class.
We define them in the class then make them available at the top of the controller.

```ruby
helper_method :current_user
```

We also want to make an if-else tree in the layout if a user is logged in we should
display their name and a link to log out, otherwise we should see a link to login.

### Authorizing a page in our app

Now that we have a way of checking if a user is logged in, we can check if they
are logged in before we render a new tweet form or other things that we don't want
them to see.

We can make a check before each action:

```ruby
if logged_in?
  flash[:notice] = "Must be logged in"
  redirect_to '/login'
end
```

But we would have to duplicate this code in every action, let's dry it out.

we can define a method in the ApplicationController authenticate_user:

```ruby
def authenticate_user
  unless logged_in?
    flash[:notice] = "Must be logged in"
    redirect_to '/login'
  end
end
```

We can run this authentication before the actions that we want by defining a macro
`before_action`:

```ruby
before_action :authenticate_user, only: [:new, :create, :edit, :update]
```

### Rendering views based on sessions

We can now use these authentication and authorization methods within our views
to allow the current user to edit, but not render an edit button for a different user.

### Authorizing a current user for certain actions

We still have a vulnerability, because any user that is logged in can edit anyone
else's tweet!

We have to check if the user id of the tweet matches the current user id then we
can allow the user to access the rest of the method.

```ruby
def authenticate_user_tweet
  unless @tweet.user.id == current_user
    flash[:notice] = "You must be logged in to edit this tweet"
    redirect_to '/login'
  end
end
```
