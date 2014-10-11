# coding: utf-8

module Pastel
  # Wrapes the {DecoratorChain} to allow for easy resolution
  # of string coloring.
  #
  # @api private
  class Delegator
    extend Forwardable

    attr_reader :base

    attr_reader :resolver

    def_delegators :@color, :valid?, :styles, :strip, :decorate

    def initialize(base)
      @base = base
      @color = Color.new
      @resolver = ColorResolver.new(@color)
    end

    # @api public
    def self.for(value)
      new(value)
    end

    protected

    def method_missing(method_name, *args, &block)
      new_base  = base.add(method_name)
      delegator = self.class.new(new_base)
      if args.empty?
        delegator
      else
        resolver.resolve(new_base, *args)
      end
    end

    def respond_to_missing?(name, include_all = false)
      super || @color.respond_to?(name, include_all)
    end
  end # Delegator
end # Pastel
