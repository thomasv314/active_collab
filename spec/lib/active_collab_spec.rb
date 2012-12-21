require "spec_helper"

client_config = YAML::load(File.join(File.dirname(File.expand_path(__FILE__)), 'client.yml'))

describe 'ActiveCollab' do 

  puts client_config
  pending "Yeah pendgin!"

end
