require 'spec_helper'

describe ActiveCollab::Object::Record do

  class TestClass < ActiveCollab::Object::Record 
    has_attributes :pid, :id, :name

    has_save_routes({ 
      :create => "/projects/:id",
      :update => "/projects/:id/edit",
    })
  end

  before :each do 
    @obj = TestClass.new
  end

  describe "attributes" do 
    it "#has_attributes" do 

      class TestHasAttributesClass < ActiveCollab::Object::Record
        has_attributes :silly, :funny
      end

      obj = TestHasAttributesClass.new
      obj.silly = true
      obj.funny = "lol"

      obj.silly.should eq(true)
      obj.funny.should eq("lol")

    end
  end

  describe "json serialization" do 

    it "should generate proper json" do
      @obj = TestClass.new(name: "Name", id: 5)
      @obj.to_json.should eq('{"test_class":{"id":5,"name":"Name"}}') 
    end

    it "should not generate a client with json in it" do
      @client = ActiveCollab::Client.new(API_URL, API_KEY)
      @obj = TestClass.new({ name: "Name", id: 5 }, @client)
      @obj.to_json.should eq('{"test_class":{"id":5,"name":"Name"}}') 
    end

  end

  describe "saving an object" do

    if (TESTING_API_RESPONSES)
      describe "#save" do
        client = ActiveCollab::Client.new(API_URL, API_KEY)
       
        project_name = "Project Created from ActiveCollab Gem Test Suite"
        p = ActiveCollab::Project.new({ name: project_name }, client)

        it "returns false and updates the attributes if there is an error saving the attributes" do
          p.save.should eq(false)
          p.errors.class.should eq(Hash)
          p.name.should eq(project_name)
        end

      end
    else
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
          string = "/parent/:pid/object/:id"
          @obj.build_route("/parent/:pid/object/:id").should eq("/parent/5/object/13")
        end
      end

      describe ".has_save_routes" do
        it "should create an instance method for each key its hash has.." do
          @obj.methods.include?(:create_object_path).should eq(true)
        end
        it "should return proper url routes based on object attributes" do 
          @obj.id = 5
          @obj.create_object_path.should eq("/projects/5")
        end
      end
    end

  end 

end
