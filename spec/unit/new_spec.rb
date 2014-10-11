# coding: utf-8

require 'spec_helper'

RSpec.describe Pastel do

  subject(:pastel) { described_class.new }

  describe 'coloring string' do
    it "doesn't apply styles to empty string" do
      expect(pastel.red('')).to eq('')
    end

    it "colors string" do
      expect(pastel.red("unicorn")).to eq("\e[31municorn\e[0m")
    end

    it "allows to specify variable number of arguments" do
      expect(pastel.red("unicorn", "running")).to eq("\e[31municornrunning\e[0m")
    end

    it "combines colored strings with regular ones" do
      expect(pastel.red("Unicorns") + ' will rule ' + pastel.green('the World!')).
        to eq("\e[31mUnicorns\e[0m will rule \e[32mthe World!\e[0m")
    end

    it "composes color strings" do
      expect(pastel.red.on_green.underline("unicorn")).
        to eq("\e[4m\e[42m\e[31municorn\e[0m")
    end

    it "allows to nest mixed styles" do
      expect(pastel.red("Unicorn" + pastel.green.on_yellow.underline('running') + '!')).
        to eq("\e[31mUnicorn\e[4m\e[43m\e[32mrunning\e[31m!\e[0m")
    end

    it "allows for deep nesting" do
      expect(pastel.red('r' + pastel.green('g' + pastel.yellow('y') + 'g') + 'r')).
        to eq("\e[31mr\e[32mg\e[33my\e[32mg\e[31mr\e[0m")
    end

    it "allows for variable nested arguments" do
      expect(pastel.red('r', pastel.green('g'), 'r')).
        to eq("\e[31mr\e[32mg\e[31mr\e[0m")
    end
  end

  describe '.valid?' do
    it "when valid returns true" do
      expect(pastel.valid?(:red)).to eq(true)
    end

    it "returns false when invalid" do
      expect(pastel.valid?(:unknown)).to eq(false)
    end
  end

  it "respond to styles method" do
    expect(pastel).to respond_to(:styles)
  end
end
