# encoding: utf-8

require 'spec_helper'

RSpec.describe Pastel::Color, '.code' do
  let(:string) { "This is a \e[1m\e[34mbold blue text\e[0m" }

  subject(:color) { described_class.new(enabled: true) }

  it 'finds single code' do
    expect(color.code(:black)).to eq(["\e[30m"])
  end

  it 'finds more than one code' do
    expect(color.code(:black, :green)).to eq(["\e[30m", "\e[32m"])
  end

  it "doesn't find code" do
    expect { color.code(:unkown) }.to raise_error(ArgumentError)
  end
end
