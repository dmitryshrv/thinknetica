class Wagon
  include BrandName
  include Validation

  attr_reader :type

  @@wagons = []

  def initialize(type)
    @type = type
    valid!
    @@wagons << self
  end

  def valid!
    raise 'Должен быть задан тип вагона' if @type.nil?
  end

  def self.all
    @@wagons
  end

  def is_passenger?
    @type == :passenger
  end
end
