# encoding: utf-8

require 'spec_helper'

RSpec.describe Pastel::Color, '.decorate' do
  let(:string) { 'string' }

  subject(:color) { described_class.new(enabled: true) }

  it "doesn't apply styling to empty string" do
    expect(color.decorate('')).to eq('')
  end

  it 'applies green text to string' do
    expect(color.decorate(string, :green)).to eq("\e[32m#{string}\e[0m")
  end

  it 'applies red text background to string' do
    expect(color.decorate(string, :on_red)).to eq("\e[41m#{string}\e[0m")
  end

  it 'applies style and color to string' do
    expect(color.decorate(string, :bold, :green)).to eq("\e[1m\e[32m#{string}\e[0m")
  end

  it 'applies style, color and background to string' do
    text = color.decorate(string, :bold, :green, :on_blue)
    expect(text).to eq("\e[1m\e[32m\e[44m#{string}\e[0m")
  end

  it "applies styles to nested text" do
    decorated = color.decorate(string + color.decorate(string, :red) + string, :green)
    expect(decorated).to eq("\e[32m#{string}\e[31m#{string}\e[32m#{string}\e[0m")
  end

  it 'errors for unknown color' do
    expect {
      color.decorate(string, :crimson)
    }.to raise_error(Pastel::InvalidAttributeNameError)
  end
end
