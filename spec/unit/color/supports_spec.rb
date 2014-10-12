# encoding: utf-8

require 'spec_helper'

RSpec.describe Pastel::Color, '.supports?' do
  it "isn't enabled for non tty terminal" do
    allow($stdout).to receive(:tty?).and_return(false)
    color = described_class.new

    expect(color.enabled?).to eq(false)
    expect(color.decorate("Unicorn", :red)).to eq("Unicorn")
  end

  it "isn't enabled for dumb terminal" do
    allow($stdout).to receive(:tty?).and_return(true)
    allow(ENV).to receive(:[]).with('TERM').and_return('dumb')
    color = described_class.new

    expect(color.enabled?).to eq(false)
  end

  it "is enabled for term with color support" do
    allow($stdout).to receive(:tty?).and_return(true)
    allow(ENV).to receive(:[]).with('TERM').and_return('xterm')
    color = described_class.new

    expect(color.enabled?).to eq(true)
  end

  it "is enabled for color terminal" do
    allow($stdout).to receive(:tty?).and_return(true)
    allow(ENV).to receive(:[]).with('TERM').and_return('unknown')
    allow(ENV).to receive(:[]).with('COLORTERM').and_return(true)
    color = described_class.new

    expect(color.enabled?).to eq(true)
  end

  it "forces to be enabled with supports? check" do
    color = described_class.new(enabled: false)
    allow(color).to receive(:supports?)

    expect(color.enabled?).to eq(false)
    expect(color).to_not have_received(:supports?)
  end
end
