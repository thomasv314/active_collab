# ActiveCollab

Ruby client for the active collab 3 Api.<br>
This is a work in progress on it's early development.

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
To run the test suite you must first create a config file in (`spec/client.yml')

```yaml
active_collab:
  api_url: "http://the.url.to.activecollab.com/public/api.php"
  api_key: "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789" 
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
