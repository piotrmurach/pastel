# encoding: utf-8

require 'spec_helper'

RSpec.describe Pastel::Color, '.new' do
  it "is immutable" do
    expect(described_class.new).to be_frozen
  end

  it "allows to disable coloring" do
    color = described_class.new(enabled: false)

    expect(color.enabled?).to eq(false)
    expect(color.decorate("Unicorn", :red)).to eq("Unicorn")
  end

  it "invokes screen dependency to check color support" do
    allow(TTY::Color).to receive(:color?).and_return(true)
    color = described_class.new

    expect(color.enabled?).to eq(true)
    expect(TTY::Color).to have_received(:color?)
  end
end
