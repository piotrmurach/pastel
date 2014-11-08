# coding: utf-8

module Pastel
  # Contains logic for resolving styles applied to component
  #
  # Used internally by {Delegator}.
  #
  # @api private
  class ColorResolver
    attr_reader :color

    # Initialize ColorResolver
    #
    # @param [Color] color
    #
    # @api private
    def initialize(color = Color.new)
      @color = color
    end

    # Resolve uncolored string
    #
    # @api private
    def resolve(base, *args)
      unprocessed_string = args.join
      color.decorate(unprocessed_string, *base)
    end
  end # ColorResolver
end # Pastel
