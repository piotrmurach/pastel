# coding: utf-8

require 'spec_helper'

RSpec.describe Pastel, '.alias_color' do

  subject(:pastel) { described_class.new(enabled: true) }

  it "aliases color" do
    pastel.alias_color(:funky, :red)
    expect(pastel.funky('unicorn')).to eq("\e[31municorn\e[0m")
  end

  it "aliases color and combines with regular ones" do
    pastel.alias_color(:funky, :red)
    expect(pastel.funky.on_green('unicorn')).to eq("\e[31;42municorn\e[0m")
  end
end
