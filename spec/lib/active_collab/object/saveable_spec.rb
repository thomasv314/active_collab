require 'spec_helper'

describe ActiveCollab::Object::Saveable do

  class TestClass < ActiveCollab::Object::Record 
    attr_accessor :pid, :id
    has_save_routes({ 
      :create => "/projects/:id",
      :update => "/projects/:id/edit",
    })
  end

  before :each do 
    @obj = TestClass.new
  end

  describe "#save" do
    it "returns a boolean" do
      @obj.methods.include?(:save).should eq(true)
    end
  end

  describe "#saved?" do
    it "tells you whether an object has been saved" do
      @obj.saved?.should eq(false)
      @obj.id = 5
      @obj.saved?.should eq(true)
    end
  end

  describe "#build_route_string" do
    it "takes symbolized urls and returns a url based off object attributes" do  
      @obj.pid = 5
      @obj.id = 13
      string = "/parent_object/:pid/object/:id"
      @obj.build_route("/parent_object/:pid/object/:id").should eq("/parent_object/5/object/13")
    end
  end

  describe ".has_save_routes" do
    it "should create an instance method for each key its hash has.." do
      @obj.methods.include?(:create_object_path).should eq(true)
    end

    it "the instance methods for each key should return data pertinent to that instance" do 
      @obj.id = 5
      @obj.create_object_path.should eq("/projects/5")
    end
  end

end
