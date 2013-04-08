require 'spec_helper'

describe 'ActiveCollab Client' do

  if TESTING_API_RESPONSES
    context 'authenticating with username and password' do
      before :each do
        @client = ActiveCollab::Client.new(API_URL)
      end

      it 'returns token string if authentication succeeds' do
        username = CONFIG['user']['name']
        password = CONFIG['user']['password']
        @client.authenticate(username, password).class.should eq(String)
      end

      it 'returns false if authentication fails' do
        username = "lolwatusername"
        password = "lolwatpassword"
        @client.authenticate(username, password).should eq(false)
      end
    end
  end

end
