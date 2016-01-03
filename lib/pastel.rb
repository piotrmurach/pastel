# encoding: utf-8

require 'forwardable'
require 'equatable'
require 'tty-color'

require 'pastel/ansi'
require 'pastel/alias_importer'
require 'pastel/color'
require 'pastel/color_resolver'
require 'pastel/delegator'
require 'pastel/detached'
require 'pastel/decorator_chain'
require 'pastel/version'

module Pastel
  # Raised when the style attribute is not supported
  InvalidAttributeNameError = Class.new(::ArgumentError)

  # Raised when the color alias is not supported
  InvalidAliasNameError = Class.new(::ArgumentError)

  # Create Pastel chainable API
  #
  # @example
  #   pastel = Pastel.new enabled: true
  #
  # @return [Delegator]
  #
  # @api public
  def new(options = {})
    defaults = { enabled: TTY::Color.color? }
    color    = Color.new(defaults.merge(options))
    importer = AliasImporter.new(color)
    importer.import
    resolver = ColorResolver.new(color)
    Delegator.for(resolver, DecoratorChain.empty)
  end

  module_function :new
end # Pastel
