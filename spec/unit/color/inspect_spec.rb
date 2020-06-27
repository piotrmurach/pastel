# frozen_string_literal: true

RSpec.describe Pastel::Color, "#inspect" do
  it "inspects color instance attributes" do
    expect(described_class.new(enabled: false, eachline: "\n").inspect).
      to eq("#<Pastel::Color enabled=false eachline=\"\\n\">")
  end
end
