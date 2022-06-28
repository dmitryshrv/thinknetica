class PassengerTrain < Train

  NUMBER_FORMAT = /^([a-zа-я]|\d){3}-?([a-zа-я]|\d){2}/.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number, :passenger)
    validate!
  end
end
