# frozen_string_literal: true

RSpec.describe Pastel::Delegator do
  it "returns delegator for color without argument" do
    pastel = Pastel.new(enabled: true)
    expect(pastel.red).to be_a(Pastel::Delegator)
  end

  describe "#==" do
    let(:resolver) { double(:resolver) }

    it "is equivalent with the same styles" do
      expect(described_class.new(resolver, [:red, :bold])).
        to eq(described_class.new(resolver, [:red, :bold]))
    end

    it "is not equivalent with different styles" do
      expect(described_class.new(resolver, [:red, :bold])).
        not_to eq(described_class.new(resolver, [:green, :bold]))
    end

    it "is not equivalent to another type" do
      expect(described_class.new(resolver, [:red, :bold])).not_to eq(:other)
    end
  end

  describe "#eql?" do
    let(:resolver) { double(:resolver) }

    it "is equal with the same styles" do
      expect(described_class.new(resolver, [:red, :bold])).
        to eql(described_class.new(resolver, [:red, :bold]))
    end

    it "is not equal with different styles" do
      expect(described_class.new(resolver, [:red, :bold])).
        not_to eql(described_class.new(resolver, [:green, :bold]))
    end

    it "is not equal to another type" do
      expect(described_class.new(resolver, [:red, :bold])).not_to eql(:other)
    end
  end

  describe "#inspect" do
    it "inspects delegator styles chain" do
      delegator = described_class.new(:resolver, [:red, :on_green])
      allow(delegator).to receive(:styles).and_return(red: 31, on_green: 42)
      expect(delegator.inspect).to eq("#<Pastel styles=[\"red\", \"on_green\"]>")
    end
  end

  describe "#hash" do
    it "calculates object hash" do
      expect(described_class.new(:resolver, [:red, :on_green]).hash).
        to be_a_kind_of(Numeric)
    end
  end

  describe "#respond_to_missing?" do
    context "for a method defined on" do
      it "returns true" do
        resolver = double(:resolver)
        chain = double(:chain)
        decorator = described_class.new(resolver, chain)
        expect(decorator.method(:styles)).not_to be_nil
      end
    end

    context "for an undefined method " do
      it "returns false" do
        resolver = double(:resolver, color: true)
        chain = double(:chain)
        decorator = described_class.new(resolver, chain)
        expect { decorator.method(:unknown) }.to raise_error(NameError)
      end
    end
  end
end
