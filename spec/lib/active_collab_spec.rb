require "spec_helper"

describe 'ActiveCollab' do 

  before :each do
    @client = ActiveCollab::Client.new(API_URL, API_KEY)
  end

  describe '#initialize' do
    it "should return an Active Collab client" do  
      @client.class.should eq(ActiveCollab::Client)
    end 
  end

  describe '#projects' do
    it "should return an array of projects" do
      @client.projects.class.should eq(Array)
    end
  end

  describe '#project(id)' do
    it "should return the project you're looking for" do
      id = CONFIG['projects']['with_tasks']
      project = @client.project(CONFIG['projects']['with_tasks'])
      
      project.id.should eq(id)
    end
  end
end
