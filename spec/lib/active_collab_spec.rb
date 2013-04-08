require "spec_helper"

describe 'ActiveCollab Module' do 

  before :each do
    @client = ActiveCollab::Client.new(API_URL, API_KEY)
  end

  describe "initialization" do
    it "lets you set a global api_key and api_url" do
      ActiveCollab.api_key = API_KEY
      ActiveCollab.api_url = API_URL

      client = ActiveCollab.client
      client.api_key.should eq(API_KEY)
      client.api_url.should eq(API_URL)
    end
  end

  describe '#initialize' do
    it "should return an Active Collab client" do  
      @client.class.should eq(ActiveCollab::Client)
    end 
  end

end
