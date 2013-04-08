require 'spec_helper'

describe 'ActiveCollab Client' do

  before :each do 
    @client = ActiveCollab::Client.new(API_URL, API_KEY)
  end

  it 'authenticates users via email and password' do

  end

end
