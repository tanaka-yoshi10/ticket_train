class Ticket
  attr_reader :errors
  def initialize(price)
    @price = price
    @errors = []
  end

  def enter(station)
    if @entry
      @errors.push "入場済み"
      return false 
    end
    @entry = station
    true
  end

  def exit(station)
    table = {梅田:1, 十三: 2, 庄内: 3, 岡町: 4}
    fee = [0, 150, 180, 220]
    distance = (table[@entry] - table[station]).abs
    if distance == 0
      @errors.push "料金不足"
      return false 
    end
    p @price , fee[distance]
    @price >= fee[distance]
  end
end
