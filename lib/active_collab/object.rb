class ActiveCollab::Object 

  def set_attributes(hash)
    puts "MY CLASS! #{self.class}"
    puts "WTF? #{self}"
    hash.each do |key, value|
      method = "#{key}="
      if self.class.method_defined? method
        self.send(method, value)
      end
    end
  end

  def client
    @client
  end

end

