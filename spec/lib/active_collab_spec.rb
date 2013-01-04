require "spec_helper"

describe 'ActiveCollab Module' do 

  before :each do
    @client = ActiveCollab::Client.new(API_URL, API_KEY)
  end

  describe "initialization" do
    it "lets you set a global api_key and api_url" do
      ActiveCollab.api_key = API_KEY
      ActiveCollab.api_url = API_URL

      client = ActiveCollab.client
      client.api_key.should eq(API_KEY)
      client.api_url.should eq(API_URL)
    end
  end

  describe '#initialize' do
    it "should return an Active Collab client" do  
      @client.class.should eq(ActiveCollab::Client)
    end 
  end

  pending "This needs to be moved to the project spec and not the module." do
    describe '#projects' do
      it "should return an array of projects" do
        @client.projects.class.should eq(Array)
      end
    end

    if (TESTING_API_RESPONSES)

      describe '#project(id)' do
        it "should return the project you're looking for" do
          id = CONFIG['projects']['with_tasks']
          project = @client.project(CONFIG['projects']['with_tasks'])

          project.id.should eq(id)
        end
      end

    end
  end

end
