# coding: utf-8

require 'spec_helper'

RSpec.describe Pastel::Color do

  subject(:color) { described_class.new(enabled: true) }

  it "exposes all available style ANSI codes" do
    expect(color.styles[:red]).to eq("\e[31m")
  end
end
