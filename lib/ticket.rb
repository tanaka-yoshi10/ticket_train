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

    if @entry.nil?
      @errors.push "入場記録なし"
      return false
    end
    distance = (table[@entry] - table[station]).abs
    if @exit
      @errors.push "出場済み"
      return false
    end
    if distance == 0
      @errors.push "同一駅"
      return false
    end
    if @price < fee[distance]
      @errors.push "料金不足"
      return false
    end
    @exit = station
    true
  end
end
