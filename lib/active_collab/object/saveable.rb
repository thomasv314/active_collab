module ActiveCollab::Object

  module Saveable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def has_attributes(*args)
        args.each do |attr|
          self.send(:define_method, "#{attr}") do 
            @attributes[attr]
          end

          self.send(:define_method, "#{attr}=") do |value| 
            @attributes[attr] = value
          end
        end
      end

      def has_save_routes(hash)
        hash.each do |key, val| 
          self.send(:define_method, "#{key}_object_path".to_sym) do
            build_route(val)
          end
        end
      end
    end

    def save
      true
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
