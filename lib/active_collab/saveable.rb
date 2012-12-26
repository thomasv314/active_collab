module ActiveCollab::Saveable

  module ClassMethods
    def has_save_routes(hash)
      puts "Save routes:\n#{hash}"
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def save
    true   
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
