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

  def mark_enteried(station)
    @entry = station
  end

  def mark_exited(station)
    @exit = station
  end
end
