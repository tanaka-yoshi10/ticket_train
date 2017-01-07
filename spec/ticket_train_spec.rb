require 'spec_helper'
require 'ticket'

describe TicketTrain do
  it 'has a version number' do
    expect(TicketTrain::VERSION).not_to be nil
  end

  it 'scenario1' do
    ticket = Ticket.new(150)
    expect(ticket.enter(:梅田)).to eq(true)
    expect(ticket.exit(:十三)).to eq(true)
    # TODO: 例外の方が良い？
  end

  it 'scenario2' do
    ticket = Ticket.new(150)
    expect(ticket.enter(:梅田)).to eq(true)
    expect(ticket.exit(:庄内)).to eq(false)
  end

  it 'scenario3' do
    ticket = Ticket.new(180)
    expect(ticket.enter(:梅田)).to eq(true)
    expect(ticket.exit(:庄内)).to eq(true)
  end

  it 'scenario4' do
    ticket = Ticket.new(220)
    expect(ticket.enter(:梅田)).to eq(true)
    expect(ticket.exit(:庄内)).to eq(true)
  end

  it 'scenario5' do
    ticket = Ticket.new(180)
    expect(ticket.enter(:梅田)).to eq(true)
    expect(ticket.exit(:岡町)).to eq(false)
  end

  it 'scenario6' do
    ticket = Ticket.new(220)
    expect(ticket.enter(:梅田)).to eq(true)
    expect(ticket.exit(:岡町)).to eq(true)
  end

  it 'scenario7' do
    ticket = Ticket.new(150)
    expect(ticket.enter(:十三)).to eq(true)
    expect(ticket.exit(:岡町)).to eq(false)
  end

  it 'scenario8' do
    ticket = Ticket.new(180)
    expect(ticket.enter(:十三)).to eq(true)
    expect(ticket.exit(:岡町)).to eq(true)
  end

  it 'scenario9' do
    ticket = Ticket.new(180)
    expect(ticket.enter(:岡町)).to eq(true)
    expect(ticket.exit(:十三)).to eq(true)
    # TODO: もう少し必要？
  end

  it 'scenario10' do
    ticket = Ticket.new(150)
    expect(ticket.enter(:梅田)).to eq(true)
    expect(ticket.exit(:梅田)).to eq(false)
  end
end
