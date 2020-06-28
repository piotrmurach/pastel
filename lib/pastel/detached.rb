# frozen_string_literal: true

module Pastel
  # A class representing detached color
  class Detached
    # Initialize a detached object
    #
    # @param [Pastel::Color] color
    #   the color instance
    # @param [Array[Symbol]] styles
    #   the styles to be applied
    #
    # @api private
    def initialize(color, *styles)
      @color  = color
      @styles = styles.dup
      freeze
    end

    # Decorate the values corresponding to styles
    #
    # @example
    #   Detached(Color.new, :red, :bold).call("hello")
    #   # => "\e[31mhello\e[0m"
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
    alias [] call

    # @api public
    def to_proc
      self
    end

    # Compare detached objects for equality of attributes
    #
    # @return [Boolean]
    #
    # @api public
    def eql?(other)
      instance_of?(other.class) && styles.eql?(other.styles)
    end

    # Compare detached objects for equivalence of attributes
    #
    # @return [Boolean]
    #
    # @api public
    def ==(other)
      other.is_a?(self.class) && styles == other.styles
    end

    # Inspect this instance attributes
    #
    # @return [String]
    #
    # @api public
    def inspect
      "#<#{self.class.name} styles=#{styles.inspect}>"
    end

    # Hash for this instance and its attributes
    #
    # @return [Numeric]
    #
    # @api public
    def hash
      [self.class, styles].hash
    end

    protected

    # @api private
    attr_reader :styles
  end # Detached
end # Pastel
