# frozen_string_literal: true

require "tty-color"

require_relative "pastel/alias_importer"
require_relative "pastel/color"
require_relative "pastel/color_resolver"
require_relative "pastel/delegator"
require_relative "pastel/version"

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
  # @param [Boolean] :enabled
  #   whether or not to disable coloring
  # @param [Boolean] :eachline
  #   whether or not to wrap eachline with separate coloring
  #
  # @return [Delegator]
  #
  # @api public
  def new(enabled: nil, eachline: false)
    if enabled.nil?
      enabled = (TTY::Color.windows? || TTY::Color.color?)
    end
    color    = Color.new(enabled: enabled, eachline: eachline)
    importer = AliasImporter.new(color, ENV)
    importer.import
    resolver = ColorResolver.new(color)
    Delegator.wrap(resolver)
  end
  module_function :new
end # Pastel
