class Station
  attr_reader :trains, :name 

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train) #помещаем поезд на станцию
    trains << train
  end
  
  def trains_by_type(type) #поезда заданного типа
    trains.select { |train| train.type == type}
  end

  def depart_train(train) #Отправляем поезд со станции
    trains.delete(train)
  end
end


class Route
  attr_reader :route

  def initialize(first_station, last_station)
    @route = [first_station, last_station]
  end

  def add_station(station) #помещаем станцию в маршрут, делаем ее предпоследней 
    route.insert(-2, station)
  end

  def remove_station(station) #удалаяем станцию из маршрута, если она не является первой или последний
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
    @size -= 1 unless @speed.zero? && @size.zero?
  end
  
  def set_route(route) #задаем поезду маршрут, ставим на первую станцию и добавляем поезд на станцию
    @route = route
    @current_station_index = 0
    @route.route.first.get_train(self)
  end
  
  def move_next_station #двигаем по маршруту, пока не достигли последней станции
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

  def current_staion
    @route[@current_station_index]
  end

  def next_station
    @route[@current_station_index + 1] unless @route[@current_station_index] == @route.last
  end

  def prev_station
    @route[@current_station_index - 1] unless @route[@current_station_index] == @route.first
  end
end