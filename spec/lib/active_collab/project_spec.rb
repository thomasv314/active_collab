require 'spec_helper'

describe ActiveCollab::Project do

  before :each do 
    @client = ActiveCollab::Client.new(API_URL, API_KEY)
  end

  if (TESTING_API_RESPONSES)
    describe "#tasks" do
      it "should return the project's tasks if it has a client" do 
        project = @client.projects.first
        project.tasks.class.should eq(Array)
      end
    end
  end
end
