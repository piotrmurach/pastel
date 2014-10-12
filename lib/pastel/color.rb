# encoding: utf-8

module Pastel
  # A class responsible for coloring strings.
  class Color
    include Equatable
    include ANSI

    attr_reader :enabled
    alias_method :enabled?, :enabled

    # Initialize a Terminal Color
    #
    # @api public
    def initialize(options = {})
      @enabled = options.fetch(:enabled) { supports? }
    end

    # Disable coloring of this terminal session
    #
    # @api public
    def disable!
      @enabled = false
    end

    # Detect terminal color support
    #
    # @return [Boolean]
    #   true when terminal supports color, false otherwise
    #
    # @api public
    def supports?
      return false unless $stdout.tty?
      return false if ENV['TERM'] == 'dumb'
      if ENV['TERM'] =~ /^screen|^xterm|^vt100|color|ansi|cygwin|linux/i
        return true
      end
      return true if ENV.include?('COLORTERM')
      true
    end

    # Apply ANSI color to the given string.
    #
    # @param [String] string
    #   text to add ANSI strings
    #
    # @param [Array[Symbol]] colors
    #
    # @example
    #   color.decorate "text", :yellow, :on_green, :underline
    #
    # @return [String]
    #
    # @api public
    def decorate(string, *colors)
      return string if string.empty? || !enabled
      validate(*colors)
      ansi_colors = colors.map { |color| lookup(color) }
      ansi_string = "#{ansi_colors.join}#{string}#{ANSI::CLEAR}"
      if ansi_string =~ /(#{Regexp.quote(ANSI::CLEAR)}){2,}/
        ansi_string.gsub!(/(#{Regexp.quote(ANSI::CLEAR)}){2,}/, '')
      end
      matches = ansi_string.scan(/#{Regexp.quote(ANSI::CLEAR)}/)
      if matches.length >= 2
        ansi_string.sub!(/#{Regexp.quote(ANSI::CLEAR)}/, ansi_colors.join)
      end
      ansi_string
    end

    # Same as instance method.
    #
    # @return [String]
    #
    # @api public
    def self.decorate(string, *colors)
      new.decorate(string, *colors)
    end

    # Strip ANSI color codes from a string.
    #
    # @param [String] string
    #
    # @return [String]
    #
    # @api public
    def strip(string)
      string.to_s.gsub(/(\[)?\033(\[)?[;?\d]*[\dA-Za-z](\])?/, '')
    end

    # Return raw color code without embeding it into a string.
    #
    # @return [Array[String]]
    #   ANSI escape codes
    #
    # @api public
    def code(*colors)
      validate(*colors)
      colors.map { |color| lookup(color) }
    end

    # Find color representation.
    #
    # @param [Symbol,String] color
    #   the color name to lookup by
    #
    # @return [String]
    #   the ANSI code
    #
    # @api private
    def lookup(color)
      self.class.const_get(color.to_s.upcase)
    end

    # Expose all ANSI color names and their codes
    #
    # @return [Hash[Symbol]]
    #
    # @api public
    def styles
      ANSI.constants(false).each_with_object({}) do |col, acc|
        acc[col.to_sym.downcase] = lookup(col)
        acc
      end
    end

    # List all available style names
    #
    # @return [Array[Symbol]]
    #
    # @api public
    def style_names
      styles.keys
    end

    # Check if provided colors are known colors
    #
    # @param [Array[Symbol,String]]
    #   the colors to check
    #
    # @reutrn [Boolean]
    #
    # @api public
    def valid?(*colors)
      colors.all? { |color| style_names.include?(color.to_sym) }
    end

    protected

    # @api private
    def validate(*colors)
      return if valid?(*colors)
      fail InvalidAttributeNameError, 'Bad style or unintialized constant, ' \
        " valid styles are: #{style_names.join(', ')}."
    end
  end # Color
end # TTY
