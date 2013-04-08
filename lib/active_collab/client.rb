require 'active_collab/api/projects'
require 'active_collab/api/tasks'
require 'active_collab/api/time_records'
require 'active_collab/api/users'

class ActiveCollab::Client

  attr_accessor :api_url, :api_key 

  # Accepts either one or two parameters
  # One: api_url
  # Two: api_url, api_key
  def initialize(*args)
 
    @client = self
    @api_url = args[0]

    if args.length == 2
      @api_key = args[1]
    end 

  end

  # Sends a GET request to the provided path
  def ac_get_request(path)
    path = build_url(path)
    response = HTTParty.get(path)
    if response.code == 200
      response.parsed_response
    else
      false
    end
  end

  # Sends a POST request to the provided path
  def ac_post_request(path, body)
    path = build_url(path)
    body['submitted'] = 'submitted'
    HTTParty.post(path, body: body)
  end

  # Authenticates a username and password and sets api token for client
  def authenticate(username, password)
    body = {
      'api_subscription' => {
        'email' => username,
        'password' => password,
        'client_name' => 'ActiveCollab Gem Client',
        'client_vendor' => 'https://github.com/tommyvyo/active_collab'
      },
      'submitted' => 'submitted'
    }
    
    arr = HTTParty.post(@api_url, body: body).to_s.split(" ")
    if arr.first == "API"
      arr.last
    else
      false
    end
  end

  protected
  def build_url(path)
    "#{@api_url}?path_info=#{path}&auth_api_token=#{@api_key}&format=json"
  end

end

