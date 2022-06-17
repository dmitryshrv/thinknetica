class Station
  attr_reader :trains, :name

  include InstanceCounter
  include Validation

  @@stations_all = []

  def initialize(name)
    @name = name
    valid!
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

  protected

  def valid!
    raise 'У станции должно быть название' if name.empty?
  end
end
