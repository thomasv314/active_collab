module ActiveCollab::Object

  module Saveable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def has_attributes(*args)
        args.each do |attr|
          set_attribute_methods(attr)
        end
      end

      def has_routes(hash)
        hash.each do |key, val| 
          self.send(:define_method, "object_#{key}_path".to_sym) do
            build_route(val)
          end
        end
      end

      def set_attribute_methods(attr)
        attr = attr.to_s
        self.send(:define_method, "#{attr}") do 
          @attributes[attr]
        end
        self.send(:define_method, "#{attr}=") do |value| 
          @attributes[attr] = value
        end
      end

    end

    def update_attributes(hash)
      hash.each do |key, val|
        if !self.methods.include? key.to_sym
          self.class.send(:set_attribute_methods, key)
        end
        @attributes[key.to_s] = val
      end
      @attributes 
    end

    def errors
      @errors
    end

    def save
      json = self.as_json

      if self.saved?
        path = self.object_update_path
      else
        path = self.object_create_path
      end

      response = ActiveCollab.client.ac_post_request(path, json)

      if response.code == 200
        response_hash = response.parsed_response
        update_attributes(response_hash)
        true
      elsif response.code == 500
        response_hash = response.parsed_response
        update_attributes(response_hash.delete("object_fields"))
        @errors = response_hash
        false 
      else 
        response
      end
    end

    def saved?
      !self.id.nil?
    end

    def build_route(string)
      array = string.split("/")
      built_array = []
      array.each do |str|
        if str[0] == ":"
          symbol = str.delete(":").to_sym
          str = self.send(symbol)
        end
        built_array.push(str) 
      end
      built_array.join("/")
    end

  end
end
