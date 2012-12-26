module ActiveCollab::Object::Saveable

  module ClassMethods
    def has_save_routes(hash)
      hash.each do |key, val| 
        self.send(:define_method, "#{key}_object_path".to_sym) do
          build_saveable_route(val)
        end
      end
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def save
    json = self.as_json
    json.delete("client") # for some reason the client attr gets added to json >:|     
    if saved?
      response = client.ac_post_request(update_object_path, json)
    else
      response = client.ac_post_request(create_object_path, json)
    end
    response 
  end

  def saved?
    !self.id.nil?
  end

  def build_saveable_route(string)
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
