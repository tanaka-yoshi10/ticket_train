require 'spec_helper'
require 'ticket'
require 'ticket_gate'

describe TicketTrain do
  let(:umeda_gate) { TicketGate.new(:梅田) }
  let(:juso_gate) { TicketGate.new(:十三) }
  let(:shonai_gate) { TicketGate.new(:庄内) }
  let(:okamachi_gate) { TicketGate.new(:岡町) }

  it 'シナリオ1（1区間）' do
    ticket = Ticket.new(150) # TODO: 券売機から買うとした方が良い？

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(juso_gate.exit(ticket)).to be_truthy
    # TODO: 例外の方が良い？
  end

  it 'シナリオ2（2区間・運賃不足）' do
    ticket = Ticket.new(150)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(shonai_gate.exit(ticket)).to be_falsey
  end

  it 'シナリオ3（2区間・運賃ちょうど）' do
    ticket = Ticket.new(180)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(shonai_gate.exit(ticket)).to be_truthy
  end

  it 'シナリオ4（2区間・運賃過多）' do
    ticket = Ticket.new(220)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(shonai_gate.exit(ticket)).to be_truthy
  end

  it 'シナリオ5（3区間・運賃不足）' do
    ticket = Ticket.new(180)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(okamachi_gate.exit(ticket)).to be_falsey
  end

  it 'シナリオ6（3区間・運賃ちょうど）' do
    ticket = Ticket.new(220)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(okamachi_gate.exit(ticket)).to be_truthy
  end

  it 'シナリオ7（梅田以外の駅から乗車する・運賃不足）' do
    ticket = Ticket.new(150)

    expect(juso_gate.enter(ticket)).to be_truthy
    expect(okamachi_gate.exit(ticket)).to be_falsey
  end

  it 'シナリオ8（梅田以外の駅から乗車する・運賃ちょうど）' do
    ticket = Ticket.new(180)

    expect(juso_gate.enter(ticket)).to be_truthy
    expect(okamachi_gate.exit(ticket)).to be_truthy
  end

  it 'シナリオ9（岡町方面から梅田方面へ向かう）' do
    ticket = Ticket.new(180)

    expect(okamachi_gate.enter(ticket)).to be_truthy
    expect(juso_gate.exit(ticket)).to be_truthy

    # 他にも逆パターンあっても良いかも
  end

  it 'シナリオ10（同じ駅で降りる）' do
    ticket = Ticket.new(150)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(umeda_gate.exit(ticket)).to be_falsey
    expect(umeda_gate.last_error).to eq("同一駅")
  end

  it 'シナリオ11（一度入場した切符でもう一度入場する）' do
    ticket = Ticket.new(150)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(umeda_gate.enter(ticket)).to be_falsey
    expect(umeda_gate.last_error).to eq("入場済み")
  end

  it 'シナリオ12（使用済みの切符でもう一度出場する）' do
    ticket = Ticket.new(150)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(juso_gate.exit(ticket)).to be_truthy
    expect(juso_gate.exit(ticket)).to be_falsey
    expect(juso_gate.last_error).to eq("出場済み")
  end

  it 'シナリオ13（改札を通っていない切符で出場する）' do
    ticket = Ticket.new(150)

    expect(umeda_gate.exit(ticket)).to be_falsey
    expect(umeda_gate.last_error).to eq("入場記録なし")
  end
end
