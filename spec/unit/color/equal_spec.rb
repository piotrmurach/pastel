# frozen_string_literal: true

RSpec.describe Pastel::Color, "#==" do
  it "is true with equal attributes" do
    expect(Pastel::Color.new(enabled: false, eachline: "\n")).
      to eq(Pastel::Color.new(enabled: false, eachline: "\n"))
  end

  it "is true with equivalent attributes" do
    expect(Pastel::Color.new(enabled: false, eachline: "\n")).
      to eql(Pastel::Color.new(enabled: false, eachline: "\n"))
  end

  it "is false with different enabled attribute" do
    expect(Pastel::Color.new(enabled: true, eachline: "\n")).
      not_to eq(Pastel::Color.new(enabled: false, eachline: "\n"))
  end

  it "is false with different eachline attribute" do
    expect(Pastel::Color.new(enabled: false, eachline: "\n")).
      not_to eq(Pastel::Color.new(enabled: false, eachline: "\r\n"))
  end

  it "is false with non-color" do
    expect(Pastel::Color.new(enabled: true)).not_to eq(:other)
  end
end
