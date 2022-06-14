class Wagon
  include BrandName
  attr_reader :type

  @@wagons = []

  def initialize(type)
    @type = type
    @@wagons << self
  end

  def self.all
    @@wagons
  end
end
