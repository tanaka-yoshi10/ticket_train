require 'spec_helper'
require 'ticket'
require 'ticket_gate'

describe TicketTrain do
  it 'シナリオ1（1区間）' do
    ticket = Ticket.new(150) # TODO: 券売機から買うとした方が良い？
    umeda_gate = TicketGate.new(:梅田)
    juso_gate = TicketGate.new(:十三)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(juso_gate.exit(ticket)).to be_truthy
    # TODO: 例外の方が良い？
  end

  it 'シナリオ2（2区間・運賃不足）' do
    ticket = Ticket.new(150)
    umeda_gate = TicketGate.new(:梅田)
    shonai_gate = TicketGate.new(:庄内)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(shonai_gate.exit(ticket)).to be_falsey
  end

  it 'シナリオ3（2区間・運賃ちょうど）' do
    ticket = Ticket.new(180)
    umeda_gate = TicketGate.new(:梅田)
    shonai_gate = TicketGate.new(:庄内)

    expect(umeda_gate.enter(ticket)).to be_truthy
    expect(shonai_gate.exit(ticket)).to be_truthy
  end

  # it 'scenario4' do
  #   ticket = Ticket.new(220)
  #   expect(ticket.enter(:梅田)).to be_truthy
  #   expect(ticket.exit(:庄内)).to be_truthy
  # end
  #
  # it 'scenario5' do
  #   ticket = Ticket.new(180)
  #   expect(ticket.enter(:梅田)).to be_truthy
  #   expect(ticket.exit(:岡町)).to be_falsey
  # end
  #
  # it 'scenario6' do
  #   ticket = Ticket.new(220)
  #   expect(ticket.enter(:梅田)).to be_truthy
  #   expect(ticket.exit(:岡町)).to be_truthy
  # end
  #
  # it 'scenario7' do
  #   ticket = Ticket.new(150)
  #   expect(ticket.enter(:十三)).to be_truthy
  #   expect(ticket.exit(:岡町)).to be_falsey
  # end
  #
  # it 'scenario8' do
  #   ticket = Ticket.new(180)
  #   expect(ticket.enter(:十三)).to be_truthy
  #   expect(ticket.exit(:岡町)).to be_truthy
  # end
  #
  # it 'scenario9' do
  #   ticket = Ticket.new(180)
  #   expect(ticket.enter(:岡町)).to be_truthy
  #   expect(ticket.exit(:十三)).to be_truthy
  #   # TODO: もう少し必要？
  # end
  #
  # it 'scenario10' do
  #   ticket = Ticket.new(150)
  #   expect(ticket.enter(:梅田)).to be_truthy
  #   expect(ticket.exit(:梅田)).to be_falsey
  # end
  #
  # it 'scenario11' do
  #   ticket = Ticket.new(150)
  #   expect(ticket.enter(:梅田)).to be_truthy
  #   expect(ticket.enter(:梅田)).to be_falsey
  #   expect(ticket.errors).to match_array(["入場済み"])
  #   # FIXME: 券売機に聞きたい
  # end
  #
  # it 'scenario12' do
  #   ticket = Ticket.new(150)
  #   expect(ticket.enter(:梅田)).to be_truthy
  #   expect(ticket.exit(:十三)).to be_truthy
  #   expect(ticket.exit(:十三)).to be_falsey
  #   expect(ticket.errors).to match_array(["出場済み"])
  # end
  #
  # it 'scenario13' do
  #   ticket = Ticket.new(150)
  #   expect(ticket.exit(:梅田)).to be_falsey
  #   expect(ticket.errors).to match_array(["入場記録なし"])
  # end
end
