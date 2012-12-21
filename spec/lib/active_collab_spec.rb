require "spec_helper"


describe 'ActiveCollab' do 

  describe '#initialize' do
    client = ActiveCollab::Client.new(API_URL, API_KEY)
    client.class.should eq(ActiveCollab::Client)
  end

end
