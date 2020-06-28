# frozen_string_literal: true

RSpec.describe Pastel::Detached do
  let(:color) { spy(:color) }

  subject(:pastel) { Pastel.new(enabled: true) }

  describe "#detach" do
    it "creates detached instance" do
      error = pastel.red.bold.detach
      expect(error).to be_a(Pastel::Detached)
    end

    it "ensures instance is immutable" do
      error = pastel.red.detach
      expect(error.frozen?).to be(true)
    end

    it "detaches colors combination" do
      error = pastel.red.bold.detach
      expect(error.call("unicorn")).to eq("\e[31;1municorn\e[0m")
      expect(error.call("error")).to eq("\e[31;1merror\e[0m")
    end

    it "allows array like access" do
      error = pastel.red.bold.detach
      expect(error["unicorn"]).to eq("\e[31;1municorn\e[0m")
    end

    it "allows alternative call invocation" do
      error = pastel.red.bold.detach
      expect(error.("unicorn")).to eq("\e[31;1municorn\e[0m")
    end

    it "calls detached colors with no arguments" do
      warning = pastel.yellow.detach
      expect(warning.call("")).to eq("")
    end

    it "inspects detached colors" do
      warning = pastel.yellow.bold.detach
      expect(warning.inspect).to eq("#<Pastel::Detached styles=[:yellow, :bold]>")
    end

    it "accepts multiple strings" do
      error = pastel.red.bold.detach
      expect(error.call("Unicorns", " run ", "wild"))
        .to eq("\e[31;1mUnicorns run wild\e[0m")
    end
  end

  describe "#==" do
    it "is equivalent with the same styles" do
      expect(described_class.new(color, :red, :bold)).
        to eq(described_class.new(color, :red, :bold))
    end

    it "is not equivalent with different styles" do
      expect(described_class.new(color, :red, :bold)).
        not_to eq(described_class.new(color, :green, :bold))
    end

    it "is not equivalent to another type" do
      expect(described_class.new(color, :red, :bold)).not_to eq(:other)
    end
  end

  describe "#eql?" do
    it "is equivalent with the same styles" do
      expect(described_class.new(color, :red, :bold)).
        to eql(described_class.new(color, :red, :bold))
    end

    it "is not equivalent with different styles" do
      expect(described_class.new(color, :red, :bold)).
        not_to eql(described_class.new(color, :green, :bold))
    end

    it "is not equivalent to another type" do
      expect(described_class.new(color, :red, :bold)).not_to eql(:other)
    end
  end

  describe "#inspect" do
    it "displays object information" do
      expect(described_class.new(color, :red, :bold).inspect).
        to eq("#<Pastel::Detached styles=[:red, :bold]>")
    end
  end

  describe "#hash" do
    it "calculates object hash" do
      expect(described_class.new(color, :red, :bold).hash).to be_a_kind_of(Numeric)
    end
  end
end
