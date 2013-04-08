require 'spec_helper'

describe ActiveCollab::Project do

  before :each do 
    @client = ActiveCollab::Client.new(API_URL, API_KEY)
  end

  if (TESTING_API_RESPONSES)
    
    describe "#all" do 
      it "should return an array of projects" do
        ActiveCollab::Project.all.class.should eq(Array)
      end
    end

    describe "#find" do
      it "should return the project you're looking for" do
        id = CONFIG['projects']['with_tasks']
        project = ActiveCollab::Project.find(id)
        project.id.should eq(id)
      end
    end

    describe "#tasks" do
      it "should return the project's tasks if it has a client" do 
        project = ActiveCollab::Project.all.first
        project.tasks.class.should eq(Array)
      end
    end
  end

end
