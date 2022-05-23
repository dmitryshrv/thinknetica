class Station
  attr_reader :trains, :name 

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    trains << train
  end
  
  def trains_by_type(type)
     t = trains.select { |train| train.type == type}
     puts "сейчас на станции #{@name} находятся #{t.size} поездов типа #{type}"
  end

  def depart_train(train)
    trains.delete(train)
  end
end


class Route
  attr_reader :route

  def initialize(first_station, last_station)
    @route = [first_station, last_station]
  end

  def add_station(station)
    route.insert(-2, station)
  end

  def remove_station(station)
    if station != route.first && station != route.last
      route.delete(station)
    else
      p 'Нельзя удалять из маршрута первую и конечную станции'
    end 
  end

  def show_route
    puts "Текущий маршрут:"
    @route.each {|station| p station.name }
  end
end


class Train
  attr_reader :speed, :size, :type

  def initialize(number, type, size)
    @number = number
    @type = type
    @size = size
    @speed = 0
  end

  def speed_up(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @size += 1 unless @speed.zero?  
  end

  def delete_wagon
    @size -= 1 unless @speed.zero?
  end
  
  def set_route(route)
    @route = route
    @current_station_index = 0
    @route.route.first.get_train(self)
  end
  
  def move_next_station
    @route.route[@current_station_index].depart_train(self)

    unless @route.route[@current_station_index + 1] == @route.route.last 
      @route.route[@current_station_index + 1].get_train(self)
    else
      @route.route.last.get_train(self)
      p "Нельзя уехать дальше последней станции"
    end

    @current_station_index += 1
  end

  def move_prev_staion
    @route.route[@current_station_index].depart_train(self)

    unless @route.route[@current_station_index - 1] == @route.route.first 
      @route.route[@current_station_index - 1].get_train(self)
    else
      @route.route.first.get_train(self)
      p "Нельзя уехать дальше первой станции"
    end

    @current_station_index -= 1
  end

  def show_current_staion
    p "текущая станция маршрута #{@route[@current_station_index].name}"
  end

  def show_next_station
    if @route[@current_station_index] == @route.last
      p "Вы на последней станции маршрута"
    else
     p "следующая станция маршрута #{@route[@current_station_index + 1].name}"
    end
  end

  def show_prev_station
    if @route[@current_station_index] == @route.first
      p "Вы на первой станции маршрута"
    else
     p "Предыдущая станция маршрута #{@route[@current_station_index - 1].name}"
    end
  end

end