require 'active_model'
require 'active_collab/object/saveable'

module ActiveCollab::Object
  class Record 

    include ActiveCollab::Object::Saveable
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON

    attr_accessor :attributes

    def initialize(attributes = {}) 
      @attributes = {}
      update_attributes(attributes)
    end

    def initialize(attributes = {}, client = nil) 
      @attributes = {}
      @client = client
      update_attributes(attributes)
    end

    def client
      @client
    end

    def update_attributes(hash)
      puts "OLD ATTRIBS! \n#{@attributes}"
      hash.each do |key, val|
        @attributes[key.to_s] = val
      end
      puts "NEW ATTRIBUTES! \n #{@attributes}"
    end

  end
end
