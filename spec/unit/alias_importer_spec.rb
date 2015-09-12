# coding: utf-8

require 'spec_helper'

RSpec.describe Pastel::AliasImporter, '.import' do
  let(:color) { spy(:color, alias_color: true) }
  let(:output) { StringIO.new }

  subject(:importer) { described_class.new(color, output) }

  it "imports aliases from environment" do
    color_aliases = "funky=red,base=bright_yellow"
    allow(ENV).to receive(:[]).with('PASTEL_COLORS_ALIASES').
      and_return(color_aliases)

    importer.import

    expect(color).to have_received(:alias_color).twice
  end

  it "fails to import incorrectly formatted colors" do
    color_aliases = "funky red,base=bright_yellow"
    allow(ENV).to receive(:[]).with('PASTEL_COLORS_ALIASES').
      and_return(color_aliases)

    importer.import

    output.rewind
    expect(output.string).to eq("Bad color mapping `funky red`\n")
    expect(color).to have_received(:alias_color).with(:base, :bright_yellow)
  end
end
