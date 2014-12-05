# ActiveCollab

###### This project is no longer maintained or developed.

Ruby API Client for ActiveCollab 3.
This is a work in progress, forked from `jera/active_collab`. 

It has at this point become largely a rewrite of the original code base to provide a more ActiveModel-ish feel to the client.
I have tried my hardest (and I think I've succeeded) at maintaining backwards compatibility with the original codebase and it's methods. 

[![Build Status](https://travis-ci.org/thomasv314/active_collab.png?branch=master)](https://travis-ci.org/tommyvyo/active_collab)

## Installation

Add this line to your application's Gemfile:

    gem 'active_collab'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_collab

## Usage

### Standalone

```ruby
require 'active_collab'

# Authenticating with ActiveCollab
ActiveCollab.api_key = "abcdefghijklmnopqrstuvwxyz0123"
ActiveCollab.api_url = "http://myactivecollabinstance.com/api.php"

# Retrieve an array of all the projects
projects = ActiveCollab::Project.all

# Retrieve a specific project with the url http://api.com/public/index.php?path_info=projects/sample
sample_project = ActiveCollab::Project.find("sample")
```

### Authenticating and making requests as specific users
So long as the authenticating user's role has the 'Use API' permission in the ActiveCollab admin panel, you can initialize a new client and #authenticate(username, password) to retrieve an API token.
If authentication fails for whatever reason it will return false, otherwise it will return a string token.

```ruby
token = ActiveCollab::Client.authenticate("myemail@mycompany.com", "mypassword123")
ActiveCollab.api_key = token
```

### Rails 2 / 3
In the `initializers/` folder in your Rails app create a file called `active_collab.rb`

```ruby
ActiveCollab.api_key = "abcdefghijklmnopqrstuvwxyz0123"
ActiveCollab.api_url = "http://myactivecollabinstance.com/api.php"
```

Now anywhere inside your app you can create and manipulate ActiveCollab objects in the same way you do ActiveRecord objects:

```ruby
project = ActiveCollab::Projects.new(name: "My Cool New Project")
project.save
=> false

project.errors 
=> { :company_id => "Cannot be blank!" }

project.company_id = 1

project.save
=> true
```

## Tests
To run the test suite you must first create a config file in (`spec/client.yml`). 
Afterwards `bundle install` and `bundle exec guard` will give you a PRY console capable of running the specs.
For 100% pass you'll need to fill in the projects section with slugs for projects relate to the attribute name. 

```yaml
client:
  api_url: "http://the.url.to.activecollab.com/public/api.php"
  api_key: "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789" 

projects: 
  with_tasks: "slug-of-project-with-tasks"
  without_tasks: "slug-of-project-without-any-tasks"
  bad_url: "lolololwat" 
```

Contributions will not be accepted if they do not pass on Travis-CI.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
