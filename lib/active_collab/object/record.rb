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

    def self.all
      
    end

    def client
      ActiveCollab.client
    end

  end
end
