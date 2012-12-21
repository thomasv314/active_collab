class ActiveCollab::Object 

  def initialize(hash = {}) 
    set_attributes(hash)
  end

  def initialize(hash = {}, client = nil) 
    set_attributes(hash)
    @client = client
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

