class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name

  validate :name, :presence
  validate :name, :type, String

  @@stations_all = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations_all << self
    register_instance
  end

  def self.all
    @@stations_all
  end

  def add_train(train)
    trains << train
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def depart_train(train)
    trains.delete(train)
  end

  def list(&block)
    @train.each { |train| block.call(train) } if block_given?
  end
end
