# encoding: utf-8

require 'spec_helper'

RSpec.describe Pastel::Color, '.strip' do
  let(:instance) { described_class.new }

  subject(:color) { instance.strip(string) }

  context 'with ansi colors' do
    let(:string)   { "This is a \e[1m\e[34mbold blue text\e[0m" }

    it 'removes color from string' do
      is_expected.to eq('This is a bold blue text')
    end
  end

  context 'with octal in encapsulating brackets' do
    let(:string) { "\[\033[01;32m\]u@h \[\033[01;34m\]W $ \[\033[00m\]" }

    it { is_expected.to eq('u@h W $ ') }
  end

  context 'with octal without brackets' do
    let(:string) { "\033[01;32mu@h \033[01;34mW $ \033[00m" }

    it { is_expected.to eq('u@h W $ ') }
  end

  context 'with octal with multiple colors' do
    let(:string) { "\e[3;0;0;t\e[8;50;0t" }

    it { is_expected.to eq('') }
  end

  context 'with control codes' do
    let(:string ) { "WARN. \x1b[1m&\x1b[0m ERR. \x1b[7m&\x1b[0m" }

    it { is_expected.to eq('WARN. & ERR. &') }
  end

  context 'with escape byte' do
    let(:string) { "This is a \e[1m\e[34mbold blue text\e[0m" }

    it { is_expected.to eq("This is a bold blue text") }
  end
end
