require 'active_model'
require 'active_collab/object/saveable'
module ActiveCollab::Object
  class Record 

    include ActiveCollab::Object::Saveable
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON

    attr_accessor :attributes


    def initialize(attributes = {}) 
      @attributes = attributes 
    end

    def initialize(attributes = {}, client = nil) 
      @attributes, @client = attributes, client
    end

    def client
      @client
    end

  end

end
