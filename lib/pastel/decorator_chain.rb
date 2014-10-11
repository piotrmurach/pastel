# coding: utf-8

module Pastel
  # Collects a list of decorators for styling a string
  #
  # @api private
  class DecoratorChain
    include Enumerable
    include Equatable

    attr_reader :decorators

    def initialize(decorators = [])
      @decorators = decorators
    end

    # Add decorator
    #
    # @api public
    def add(decorator)
      self.class.new(decorators + [decorator])
    end

    # Iterate over list of decorators
    #
    # @api public
    def each(&block)
      decorators.each(&block)
    end

    # Create an empty decorator chain
    #
    # @return [DecoratorChain]
    #
    # @api public
    def self.empty
      new([])
    end
  end # DecoratorChain
end # Patel
