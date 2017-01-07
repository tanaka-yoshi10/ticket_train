class TicketGate
  def initialize(station)
    @station = station
    @errors = []
  end

  def enter(ticket)
    if ticket.entried?
      @errors.push "入場済み"
      return false
    end

    ticket.enter(@station)
    true
  end

  def exit(ticket)
    station_positions = {梅田:1, 十三: 2, 庄内: 3, 岡町: 4}
    fees = [0, 150, 180, 220]

    unless ticket.entried?
      @errors.push "入場記録なし"
      return false
    end

    if ticket.exited?
      @errors.push "出場済み"
      return false
    end

    if ticket.entry == @station
      @errors.push "同一駅"
      return false
    end

    distance = (station_positions[ticket.entry] - station_positions[@station]).abs
    if ticket.price < fees[distance]
      @errors.push "料金不足"
      return false
    end

    ticket.exit(@station)
    true
  end

  def calculate(entry, exit)

  end

  def last_error
    @errors.last
  end
end
