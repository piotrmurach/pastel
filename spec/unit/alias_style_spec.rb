# coding: utf-8

RSpec.describe Pastel, '#alias_style' do

  subject(:pastel) { described_class.new(enabled: true) }

  it "aliases style" do
    pastel.alias_style(:danger, :red, :bold)
    expect(pastel.danger('unicorn')).to eq("\e[31;1municorn\e[0m")
  end

  it "aliases style and combines with regular ones" do
    pastel.alias_style(:danger, :red, :bold)
    expect(pastel.danger.on_green('unicorn')).to eq("\e[31;1;42municorn\e[0m")
  end

end
