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
      set_attributes(@attributes)
    end

    def initialize(attributes = {}, client = nil) 
      @attributes, @client = attributes, client
      set_attributes(@attributes)
    end

    def set_attributes(hash)
      hash.each do |key, value|
        method = "#{key}=".to_sym
        if self.methods.include? method
          self.send(method, value)
        end
      end
    end

    def client
      @client
    end

  end
end
