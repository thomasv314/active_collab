require 'spec_helper'

describe ActiveCollab::Object do
  
  before :each do 
    @client = ActiveCollab::Client.new(API_URL, API_KEY)
  end

  describe '#saved?' do
    it "should return true if the object has been saved to the server." do
       p = @client.projects.first
       p.saved?.should eq(true)
    end
  end

end
