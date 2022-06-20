class PassengerWagon < Wagon
  
  attr_reader :seats_taken

  def initialize(seats)
    @seats = seats
    @seats_taken = 0
    super(:passenger)
  end

  def take_seat
    @seats_taken += 1 if @seats_taken <= @seats
  end

  def free_seats
    @seats - @seats_taken
  end
end
