class Train
  include BrandName
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /^([a-zа-я]|\d){3}-?([a-zа-я]|\d){2}/

  attr_reader :speed, :type, :wagons, :number

  @@trains = []

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    valid!
    @wagons = []
    @@trains << self
    register_instance
  end

  def valid!
    raise 'Поезд должен иметь номер' if @number.nil?
    raise 'Поезд должен иметь тип' if @type.nil?
    raise 'Номер неправильного формата' unless @number =~ NUMBER_FORMAT
  end

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def self.all
    @@trains
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

    if @route.stations[@current_station_index + 1] == @route.stations.last
      p 'Нельзя уехать дальше последней станции'
      return
    else
      next_station.add_train(self)
    end

    @current_station_index += 1
  end

  def move_prev_staion
    current_staion.depart_train(self)

    if @route.stations[@current_station_index - 1] == @route.stations.first
      p 'Нельзя уехать дальше первой станции'
      return
    else
      prev_station.add_train(self)
    end

    @current_station_index -= 1
  end

  def list(&block)
    @wagons.each { |wagon| block.call(wagon) } if block_given?
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
