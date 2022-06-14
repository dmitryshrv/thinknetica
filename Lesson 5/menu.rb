class MainMenu

  def show_menu
    loop do
      puts ''
      puts 'УПРАВЛЕНИЕ ЖЕЛЕЗНОЙ ДОРОГОЙ'
      puts '---------------------------'
      puts '1. Управление станциями'
      puts '2. Управление поездами'
      puts '3. Управление маршрутами'
      puts '0. Выход из системы управления'

      choice = gets.to_i

      case choice
      when 1
        manage_stations
      when 2
        manage_trains
      when 3
        manage_routes
      when 0
        break
      end
    end
  end

protected

  def manage_stations
    loop do
      puts ' '
      puts 'Управление станциями'
      puts '---------------------------'
      puts '1. Добавить новую станцию'
      puts '2. Показать все станции'
      puts '3. Показать все поезда на станции'
      puts '0. Вернуться в главное меню'

      choice = gets.to_i

      case choice
      when 1
        puts ' '
        puts 'Введите название станции: '
        name = gets.chomp
        Station.new(name)
      when 2
        unless Station.all.empty?
          puts ' '
          print 'Список всех станций: '
          Station.all.each { |station| puts station.name, ' ' }
        end
      when 3
        show_trains
      when 0
        break
      end
    end
  end

  def manage_routes
    loop do
      puts ' '
      puts 'Управление маршуртами'
      puts '1. Добавить маршурт'
      puts '2. Изменить маршрут'
      puts '0. В главное меню'

      choice = gets.to_i

      case choice
      when 1
        if Station.all.size < 2
          puts 'Должно быть не менее двух станци для создания маршрута'
        else
          create_route
        end
      when 2
        change_route
      when 0
        break
      end
    end
  end

  def manage_trains
    loop do
      puts ' '
      puts 'Управление поездами'
      puts '1. Добавить поезд'
      puts '2. Прицепить / отцепить вагоны'
      puts '3. Движение по маршруту (поставить, передвинуть)'
      puts '0. Главное меню'

      choice = gets.to_i

      case choice
        when 1
          create_train
        when 2
          manage_wagons
        when 3
          train_route
        when 0
          break
        end  
    end
  end

  def show_trains
    puts ' '
    puts 'Выберите станицю'
    index = 1
    unless Station.all.empty?
      Station.all.each { |station| puts index, station.name, ' ' }
      index += 1
    end

    choice = gets.to_i
    puts ' '
    puts 'Поезда на выбранной станции:'
    Station.all[choice].trains.each {|train| puts train }
  end

  def create_route
    count = 1
    Station.all.each do |station|
      print count, ' '
      puts station.name
      count += 1
    end

    puts ' '
    puts 'Ведите номера начальной и конечно станции для создания маршрута'
    puts 'Начальная: '
    start_index = gets.to_i - 1
    puts 'Конечная: '
    final_index = gets.to_i - 1
    
    Route.new(Station.all[start_index], Station.all[final_index])
    p Route.all.last
  end

  def change_route
    loop do
      puts ' '
      puts 'Изменение маршурта'
      puts 'Выберете маршрут:'
      
      index = 1
      Route.all.each do |route|
        print index, ' ' 
        route.show_route
        index += 1
      end

      choice = gets.to_i

      puts ' '
      puts 'Выберете действие:'
      puts '1. Добавить станцию в маршурт'
      puts '2. Удалить станцию из маршрута'
      puts '0. Выйте в главное меню'

      action = gets.to_i

      case action
      when 1
        puts ' '
        puts 'Список всех доступных станций:'
        i = 1
        Station.all.each do |station| 
          print i
          puts station.name
          i += 1
        end
        puts 'Введите номер станцию для добавления в маршрут'
        name = gets.to_i
        Route.all[choice - 1].add_station(Station.all[name - 1]) unless Route.all[choice - 1].stations.include?(Station.all[name - 1])
        break

      when 2
        puts ' '
        puts 'Список станций маршрута'
        Route.all[choice - 1].show_route
        puts 'Введите номер станции для удаления'
        station_index = gets.to_i
        Route.all[choice - 1].remove_station(Station.all[station_index - 1])
        break
      when 0
        break
      end
    end
  end

  def create_train
    puts ' '
    puts 'Введите номер поезда'
    train_number = gets.chomp
    
    puts ''
    puts 'Выберите тип поезда:'
    puts '1. Пассажирский'
    puts '2. Грузовой'
    train_type = gets.to_i

    case train_type
    when 1
      PassengerTrain.new(train_number)
      puts ''
      print 'Добавлен поезд: '
      puts Train.all.last.number, ' ', Train.all.last.type
    when 2
      CargoTrain.new(train_number)
      puts ''
      print 'Добавлен поезд: '
      puts Train.all.last.number, ' ', Train.all.last.type
    end
  end

  def manage_wagons
    puts ' '
    puts 'Управление вагонами'
    show_all_trains
    train_choice = gets.to_i

    puts ''
    puts '1. Прицепить вагон'
    puts '2. Отцепить вагон'

    choice = gets.to_i

    case choice
    when 1
      if Train.all[train_choice - 1].type == :passenger
        Train.all[train_choice - 1].add_wagon(PassengerWagon.new)
      else
        Train.all[train_choice - 1].add_wagon(CargoWagon.new)
      end
    when 2
      Train.all[train_choice - 1].delete_wagon
    end
  end

  def show_all_trains
    puts 'Выберите поезд: '
    
    index_train = 1
    Train.all.each do |train|
      print index_train, ' '
      puts train.number, ' ', train.type
      index_train += 1
    end
  end

  def train_route
    loop do
      show_all_trains
      train_choice = gets.to_i

      puts ' '
      puts 'Выберите маршрут'
      index_route = 1
      Route.all.each do |route|
        print index_route, ' '
        route.show_route
        index_route += 1
      end

      choice_route = gets.to_i

      puts ' '
      puts '1. Поставить поезд на маршрут'
      puts '2. Двигать поезд по маршруту'

      choice = gets.to_i

      case choice
      when 1
        Train.all[train_choice - 1].set_route(Route.all[choice_route - 1])
        break
      when 2
        puts ' '
        puts '1. Двигаем на следующую станцию'
        puts '2. Двигаем на предыдущую станцию'
        action = gets.to_i
        
        case action
        when 1
          Train.all[train_choice - 1].move_next_station
          break
        when 2
          Train.all[train_choice - 1].move_prev_staion
          break
        end
      end
    end
  end
end
