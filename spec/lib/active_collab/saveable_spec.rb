require 'spec_helper'


describe ActiveCollab::Saveable do

  class TestClass 
    include ActiveCollab::Saveable
    attr_accessor :parent_id, :id 
  end

  it "adds a save method to any object it is included in" do
    t = TestClass.new
    t.methods.include?(:save).should eq(true)
  end

  it "takes a symbolized route and builds a proper path for it" do
    t = TestClass.new
    t.parent_id = 5
    t.id = 13
    string = "/parent_object/:parent_id/object/:id"
    t.build_saveable_route(string).should eq("/parent_object/5/object/13")
  end

end
