class Train
  attr_reader :speed, :type, :wagons, :number

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @wagons = []
  end

  def speed_up(speed)
    @speed += speed if speed > 0
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if wagon.type == type
  end

  def delete_wagon
    wagons.delete.last
  end
  
  def set_route(route)
    @route = route
    @current_station_index = 0
    @route.stations.first.add_train(self)
  end
  
  def move_next_station
    current_staion.depart_train(self) 
    
    unless @route.stations[@current_station_index + 1] == @route.stations.last 
      next_station.add_train(self) 
    else
      p 'Нельзя уехать дальше последней станции'
      return
    end

    @current_station_index += 1
  end

  def move_prev_staion
    current_staion.depart_train(self)

    unless @route.stations[@current_station_index - 1] == @route.stations.first 
      prev_station.add_train(self)
    else
      p 'Нельзя уехать дальше первой станции'
      return
    end

    @current_station_index -= 1
  end

  protected

  def current_staion
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1] unless @route.stations[@current_station_index] == @route.stations.last
  end

  def prev_station
    @route.stations[@current_station_index - 1] unless @route.stations[@current_station_index] == @route.stations.first
  end
end

