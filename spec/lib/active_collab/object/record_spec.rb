require 'spec_helper'

describe ActiveCollab::Object::Record do
  
  before :each do 
    @client = ActiveCollab::Client.new(API_URL, API_KEY)
  end


  describe "#attributes" do
    
    class AttributeTest < ActiveCollab::Object::Record 
      attr_accessor :key_one, :key_two
    end

    it "takes in a hash and sets its attributes" do
      a = AttributeTest.new({ :key_one => 1, :key_two => 2})
      a.key_one.should eq(1)
      a.key_two.should eq(2)
    end
  end

end
