require 'spec_helper'

describe ActiveCollab::Saveable do

  class TestClass 
    include ActiveCollab::Saveable
    attr_accessor :parent_id, :id 
  end

  describe "#save" do
    it "returns a boolean" do
      t = TestClass.new
      t.methods.include?(:save).should eq(true)
    end
  end
  
  describe "#saved?" do
    it "tells you whether an object has been saved" do
      t = TestClass.new
      t.saved?.should eq(false)

      t.id = 5
      t.saved?.should eq(true)
    end
  end

  describe "#build_route_string" do
    it "takes symbolized urls and returns a url based off object attributes" do  
      t = TestClass.new
      t.parent_id = 5
      t.id = 13
      string = "/parent_object/:parent_id/object/:id"
      t.build_saveable_route(string).should eq("/parent_object/5/object/13")
    end
  end

end
