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

      def has_save_routes(hash)
        hash.each do |key, val| 
          self.send(:define_method, "#{key}_object_path".to_sym) do
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
      puts "OLD ATTRIBS! \n#{@attributes}"
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
        path = self.update_object_path
      else
        path = self.create_object_path
      end

      response = @client.ac_post_request(path, json)
      if response.code == 200
        puts "THE REQUEST WAS SUCCESSFUL!"
        response_hash = response.parsed_response
        update_attributes(response_hash)
        true
      elsif response.code == 500
        puts "THE REQUEST WAS SUCCESSFUL BUT INVALID!"
        response_hash = response.parsed_response
        update_attributes(response_hash.delete("object_fields"))
        @errors = response_hash
        false 
      else 
        puts "Naw dawg. Failed."
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
