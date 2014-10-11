# coding: utf-8

require 'spec_helper'

RSpec.describe Pastel::Delegator do
  describe ".respond_to_missing?" do
    context 'for a method defined on' do
      it "returns true" do
        chain = double(:chain)
        decorator = described_class.new(chain)
        expect(decorator.method(:styles)).not_to be_nil
      end
    end

    context "for an undefined method " do
      it "returns false" do
        chain = double(:chain)
        decorator = described_class.new(chain)
        expect { decorator.method(:unknown) }.to raise_error(NameError)
      end
    end
  end
end
