# frozen_string_literal: true

require "forwardable"

require_relative "color_parser"
require_relative "decorator_chain"

module Pastel
  # Wrapes the {DecoratorChain} to allow for easy resolution
  # of string coloring.
  #
  # @api private
  class Delegator
    extend Forwardable

    def_delegators "@resolver.color", :valid?, :styles, :strip, :decorate,
                   :enabled?, :colored?, :alias_color, :lookup

    def_delegators ColorParser, :parse
    alias undecorate parse

    # Wrap resolver and chain
    #
    # @api public
    def self.wrap(resolver, chain = DecoratorChain.empty)
      new(resolver, chain)
    end

    # Create Delegator
    #
    # Used internally by {Pastel}
    #
    # @param [ColorResolver] resolver
    #
    # @param [DecoratorChain] chain
    #
    # @api private
    def initialize(resolver, chain)
      @resolver = resolver
      @chain = chain
    end

    # Compare delegated objects for equality of attributes
    #
    # @return [Boolean]
    #
    # @api public
    def eql?(other)
      instance_of?(other.class) && chain.eql?(other.chain)
    end

    # Compare delegated objects for equivalence of attributes
    #
    # @return [Boolean]
    #
    # @api public
    def ==(other)
      other.is_a?(self.class) && chain == other.chain
    end

    # Object string representation
    #
    # @return [String]
    #
    # @api
    def inspect
      "#<Pastel styles=#{chain.map(&:to_s)}>"
    end
    alias to_s inspect

    # Hash for this instance and its attributes
    #
    # @return [Numeric]
    #
    # @api public
    def hash
      [self.class, chain].hash
    end

    protected

    attr_reader :chain

    attr_reader :resolver

    # Handles color method calls
    #
    # @api private
    def method_missing(method_name, *args, &block)
      new_chain = chain.add(method_name)
      delegator = self.class.wrap(resolver, new_chain)
      if args.empty? && method_name.to_sym != :detach
        delegator
      else
        strings = args.dup
        strings << evaluate_block(&block) if block_given?
        resolver.resolve(new_chain, strings.join)
      end
    end

    # Check if color is valid
    #
    # @api private
    def respond_to_missing?(name, include_all = false)
      resolver.color.respond_to?(name, include_all) ||
        resolver.color.valid?(name) || super
    end

    # Evaluate color block
    #
    # @api private
    def evaluate_block(&block)
      delegator = self.class.wrap(resolver)
      delegator.instance_eval(&block)
    end
  end # Delegator
end # Pastel
