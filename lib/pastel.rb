# encoding: utf-8

require 'tty-color'

require 'pastel/alias_importer'
require 'pastel/color'
require 'pastel/color_resolver'
require 'pastel/delegator'
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
    unless options.key?(:enabled)
      options[:enabled] = (TTY::Color.windows? || TTY::Color.color?)
    end
    color    = Color.new(options)
    importer = AliasImporter.new(color, ENV)
    importer.import
    resolver = ColorResolver.new(color)
    Delegator.for(resolver, DecoratorChain.empty)
  end

  module_function :new
end # Pastel
