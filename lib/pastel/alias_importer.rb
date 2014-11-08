# encoding: utf-8

module Pastel
  # A class responsible for importing color aliases
  class AliasImporter
    # Create alias importer
    #
    # @example
    #   importer = Pastel::AliasImporter.new(Pastel::Color.new)
    #
    # @api public
    def initialize(color, output = $stderr)
      @color  = color
      @output = output
    end

    # Import aliases from the environment
    #
    # @example
    #   importer = Pastel::AliasImporter.new(Pastel::Color.new)
    #   importer.import
    #
    # @return [nil]
    #
    # @api public
    def import
      color_aliases = ENV['PASTEL_COLORS_ALIASES']
      return unless color_aliases
      color_aliases.split(',').each do |color_alias|
        new_color, old_color = color_alias.split('=').map(&:to_sym)
        if !new_color || !old_color
          output.puts "Bad color mapping `#{color_alias}`"
        else
          color.alias_color(new_color, old_color)
        end
      end
    end

    protected

    attr_reader :color, :output
  end # AliasImporter
end # Pastel
