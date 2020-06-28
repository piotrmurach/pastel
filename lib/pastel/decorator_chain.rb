# frozen_string_literal: true

module Pastel
  # Collects a list of decorators for styling a string
  #
  # @api private
  class DecoratorChain
    include Enumerable

    # Create an empty decorator chain
    #
    # @return [DecoratorChain]
    #
    # @api public
    def self.empty
      @empty ||= self.new
    end

    # Create a decorator chain
    #
    # @api public
    def initialize(decorators = [].freeze)
      @decorators = decorators
    end

    # Add decorator
    #
    # @param [String] decorator
    #
    # @api public
    def add(decorator)
      if decorators.include?(decorator)
        self.class.new(decorators)
      else
        self.class.new(decorators + [decorator])
      end
    end

    # Iterate over list of decorators
    #
    # @api public
    def each(&block)
      decorators.each(&block)
    end

    # Compare colors for equality of attributes
    #
    # @return [Boolean]
    #
    # @api public
    def eql?(other)
      instance_of?(other.class) && decorators.eql?(other.decorators)
    end

    # Compare colors for equivalence of attributes
    #
    # @return [Boolean]
    #
    # @api public
    def ==(other)
      other.is_a?(self.class) && decorators == other.decorators
    end

    # Inspect this instance attributes
    #
    # @return [String]
    #
    # @api public
    def inspect
      "#<#{self.class.name} decorators=#{decorators.inspect}>"
    end

    # Hash for this instance and its attributes
    #
    # @return [Numeric]
    #
    # @api public
    def hash
      [self.class, decorators].hash
    end

    protected

    attr_reader :decorators
  end # DecoratorChain
end # Patel
