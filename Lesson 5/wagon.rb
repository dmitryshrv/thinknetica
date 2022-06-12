class Wagon
  include brand
  attr_reader :type

  def initialize(type)
    @type = type
  end
end
