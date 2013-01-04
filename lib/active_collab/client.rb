require 'active_collab/api/projects'
require 'active_collab/api/tasks'
require 'active_collab/api/time_records'
require 'active_collab/api/users'

class ActiveCollab::Client

  attr_accessor :api_url, :api_key 

  def initialize(url, api_key)
    @api_url = url
    @api_key = api_key
    @client = self
  end

  def ac_get_request(path)
    path = build_url(path)
    response = HTTParty.get(path)
    if response.code == 200
      response.parsed_response
    else
      false
    end
  end

  def ac_post_request(path, body)
    path = build_url(path)
    body['submitted'] = 'submitted'
    HTTParty.post(path, :body => body)
  end

  protected
  def build_url(path)
    "#{@api_url}?path_info=#{path}&auth_api_token=#{@api_key}&format=json"
  end

end

