class Route
  attr_reader :stations
  include InstanceCounter

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
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
    @stations.each { |station| print station.name, ' '  }
    puts ' '
  end
end
