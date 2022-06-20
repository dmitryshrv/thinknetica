class CargoWagon < Wagon
  attr_reader :volume_taken

  def initialize(volume)
    @volume = volume
    @volume_taken = 0
    super(:cargo)
  end

  def take_volume
    @volume_taken += 1 if @volume_taken <= @volume
  end

  def free_volume
    @volume - @volume_taken
  end
end
