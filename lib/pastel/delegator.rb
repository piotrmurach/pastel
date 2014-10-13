# coding: utf-8

require 'forwardable'

module Pastel
  # Wrapes the {DecoratorChain} to allow for easy resolution
  # of string coloring.
  #
  # @api private
  class Delegator
    extend Forwardable
    include Equatable

    def_delegators '@resolver.color', :valid?, :styles, :strip, :decorate, :enabled?

    def initialize(resolver, base)
      @resolver = resolver
      @base     = base
    end

    # @api public
    def self.for(resolver, base)
      new(resolver, base)
    end

    protected

    attr_reader :base

    attr_reader :resolver

    def wrap(base)
      self.class.new(resolver, base)
    end

    def method_missing(method_name, *args, &block)
      new_base  = base.add(method_name)
      delegator = wrap(new_base)
      if args.empty?
        delegator
      else
        resolver.resolve(new_base, *args)
      end
    end

    def respond_to_missing?(name, include_all = false)
      super || @resolver.color.respond_to?(name, include_all)
    end
  end # Delegator
end # Pastel
