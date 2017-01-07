class Ticket
  attr_reader :entry
  attr_reader :exit
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def entried?
    @entry
  end

  def exited?
    @exit
  end

  def enter(station)
    @entry = station
  end

  def exit(station)
    @exit = station
  end
end
