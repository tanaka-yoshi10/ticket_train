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

    ticket.mark_enteried(@station)
    true
  end

  def exit(ticket)
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

    if ticket.price < fee_from(ticket.entry)
      @errors.push "料金不足"
      return false
    end

    ticket.mark_exited(@station)
    true
  end

  def fee_from(entry)
    station_positions = {梅田:1, 十三: 2, 庄内: 3, 岡町: 4}
    fees = [0, 150, 180, 220]

    distance = (station_positions[entry] - station_positions[@station]).abs
    fees[distance]
  end

  def last_error
    @errors.last
  end
end
