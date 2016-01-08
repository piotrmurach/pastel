# encoding: utf-8

RSpec.describe Pastel::Color, '#lookup' do
  it "looksup colors" do
    color = described_class.new(enabled: true)
    expect(color.lookup(:red, :on_green, :bold)).to eq("\e[31;42;1m")
  end
end
