class Route
  include InstanceCounter
  include Validation

  attr_reader :stations
  
  validate :stations, :presence

  @@routes = []

  def initialize(first_station, last_station)
    validate!
    @stations = [first_station, last_station]
    @@routes << self
    register_instance
  end

  def self.all
    @@routes
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    if [stations.first, stations.last].include?(station)
      puts 'Нельзя удалять из маршрута первую и конечную станции'
    else
      stations.delete(station)
    end
  end

  def show_route
    @stations.each { |station| print station.name, ' ' }
    puts ' '
  end
end
