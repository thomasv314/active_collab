require 'spec_helper'

describe ActiveCollab::Object::Record do

  class TestClass < ActiveCollab::Object::Record 
    has_attributes :pid, :id, :name
    has_routes({ 
      :create  => "/projects/add",
      :read    => "/projects/:id",
      :update  => "/projects/:id/edit",
      :destroy => "",
      :index   => ""
    })
  end

  before :each do 
    @obj = TestClass.new(name: "Name", id: 5)
  end

  describe "attributes" do 
    it "#has_attributes" do 
      @obj.pid = "pid"
      @obj.pid.should eq("pid")
    end
  end

  describe "json serialization" do 
    it "should generate proper json" do
      @obj.to_json.should eq('{"test_class":{"id":5,"name":"Name"}}') 
    end

    it "should not generate a client with json in it" do
      @obj.to_json.should eq('{"test_class":{"id":5,"name":"Name"}}') 
    end
  end

  describe "object routes" do
    describe "#build_route_string" do
      it "takes symbolized urls and returns a url based off object attributes" do  
        @obj.pid = 5
        @obj.id = 13
        string = "/parent/:pid/object/:id"
        @obj.build_route("/parent/:pid/object/:id").should eq("/parent/5/object/13")
      end
    end
    describe ".has_routes" do
      it "should create an instance method for each key its hash has.." do
        @obj.methods.include?(:object_create_path).should eq(true)
      end
      it "should return proper url routes based on object attributes" do 
        @obj.id = 5
        @obj.object_create_path.should eq("/projects/add")
      end
    end
  end

  describe "querying" do

    describe "all" do
      it "#all should return an array of objects from the object's index path." do
        TestClass.all.class.should eq(Array) 
      end
    end

    describe "find" do
      it "#find should return an object of that instance." do
        if TESTING_API_RESPONSES
          ActiveCollab::Project.find(1).class.should eq(ActiveCollab::Project)
        end
      end
    end

  end

  describe "saving an object" do
    if TESTING_API_RESPONSES
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
          @obj.id = nil
          @obj.saved?.should eq(false)
          @obj.id = 5
          @obj.saved?.should eq(true)
        end
      end
    end
  end 

end
