class Station
  attr_reader :trains, :name
  
  include InstanceCounter

  @@stations_all = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations_all << self
    register_instance
  end

  def self.all
    stations_all
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
end
