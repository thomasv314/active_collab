require 'spec_helper'

describe ActiveCollab::Object::Saveable do

  class TestClass 
    include ActiveCollab::Object::Saveable
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

  describe ".has_save_routes" do
    class SaveRoutesTest 
      include ActiveCollab::Object::Saveable
      attr_accessor :id
      has_save_routes({ 
        :create => "/projects/:id",
        :edit => "/projects/:id/edit",
        :bananas => "/projects/:id/bananas"
      })
    end

    it "should create an instance method for each key its hash has.." do
      srt = SaveRoutesTest.new
      srt.methods.include?(:bananas_object_path).should eq(true)
      srt.methods.include?(:create_object_path).should eq(true)
    end

    it "the instance methods for each key should return data pertinent to that instance" do 
      srt = SaveRoutesTest.new
      srt.id = 5
      
      srt.bananas_object_path.should eq("/projects/5/bananas")
      srt.create_object_path.should eq("/projects/5")
    end
  end

end
