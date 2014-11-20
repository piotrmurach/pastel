# encoding: utf-8

module Pastel
  # A class representing detached color
  class Detached
    include Equatable

    def initialize(color, *styles)
      @color  = color
      @styles = styles.dup
      freeze
    end

    # Decorate the values corresponding to styles
    #
    # @example
    #
    # @param [String] value
    #   the stirng to decorate with styles
    #
    # @return [String]
    #
    # @api public
    def call(*args)
      value = args.join
      @color.decorate(value, *styles)
    end

    private

    # @api private
    attr_reader :styles
  end # Detached
end # Pastel
