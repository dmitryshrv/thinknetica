module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
  
  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.instance ||= 0
      self.class.instance += 1
    end 
  end
end

