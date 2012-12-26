# ActiveCollab

Ruby API Client for ActiveCollab 3.
This is a work in progress, forked from `jera/active_collab`. 

It has at this point become largely a rewrite of the original code base to provide a more ActiveModel-ish feel to the client.
I have tried my hardest (and I think I've succeeded) at maintaining backwards compatibility with the original codebase and it's methods.

[![Build Status](https://travis-ci.org/tommyvyo/active_collab.png?branch=master)](https://travis-ci.org/tommyvyo/active_collab)

## Installation

Add this line to your application's Gemfile:

    gem 'active_collab'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_collab

## Usage

```ruby
require 'active_collab'

#create a client
url = "http://myactivecollabinstance.com/api.php"
api_key = MY_API_KEY
client = ActiveCollab::Client.new(url,api_key)

#listing projects
projects = client.projects


#listing tasks for project_id = 1
tasks = client.tasks(1)

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
