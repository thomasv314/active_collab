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

    def client
      ActiveCollab.client
    end

    def self.find(id)
      object = self.new
      object.id = id
      response = ActiveCollab.client.ac_get_request(object.object_read_path)
      if response
        self.new(response)
      else
        false
      end
    end

    def self.all
      response = ActiveCollab.client.ac_get_request(self.new.object_index_path)
      if response.kind_of? Hash
        [ self.new(response) ]
      elsif response.kind_of? Array
        response.map do |obj|
          self.new(obj)
        end
      else
        []
      end
    end

  end
end
