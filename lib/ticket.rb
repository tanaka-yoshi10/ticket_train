class Ticket
  def initialize(price)
    @price = price
  end

  def enter(station)
    return false if @entry
    @entry = station
    true
  end

  def exit(station)
    table = {梅田:1, 十三: 2, 庄内: 3, 岡町: 4}
    fee = [0, 150, 180, 220]
    distance = (table[@entry] - table[station]).abs
    return false if distance == 0
    p @price , fee[distance]
    @price >= fee[distance]
  end
end
