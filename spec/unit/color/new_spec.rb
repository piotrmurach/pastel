# encoding: utf-8

RSpec.describe Pastel::Color, '::new' do
  it "allows to disable coloring" do
    color = described_class.new(enabled: false)

    expect(color.enabled?).to eq(false)
    expect(color.decorate("Unicorn", :red)).to eq("Unicorn")
  end

  it "allows wrapping eachline in colors" do
    color = described_class.new(eachline: "\n")

    expect(color.eachline).to eq("\n")
  end
end
