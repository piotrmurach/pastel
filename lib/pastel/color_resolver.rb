# coding: utf-8

module Pastel
  # Contains logic for resolving styles applied to component
  #
  # Used internally by {Delegator}.
  #
  # @api private
  class ColorResolver
    attr_reader :color

    def initialize(color = Color.new)
      @color = color
    end

    def resolve(base, *args)
      unprocessed_string = args.join
      base.reduce(unprocessed_string) do |component, decorator|
        color.decorate(component, decorator)
      end
    end
  end # ColorResolver
end # Pastel
