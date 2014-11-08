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
    #   the color names
    #
    # @example
    #   color.decorate "text", :yellow, :on_green, :underline
    #
    # @return [String]
    #   the colored string
    #
    # @api public
    def decorate(string, *colors)
      return string if string.empty? || !enabled

      ansi_colors = lookup(*colors)
      ansi_string = "#{ansi_colors}#{string}#{clear}"
      ansi_string = nest_color(collapse_reset(ansi_string), ansi_colors)
      ansi_string
    end

    def clear
      lookup(:clear)
    end

    # Collapse reset
    #
    # @param [String] string
    #   the string to remove duplicates from
    #
    # @return [String]
    #
    # @api private
    def collapse_reset(string)
      ansi_string = string.dup
      if ansi_string =~ /(#{Regexp.quote(clear)}){2,}/
        ansi_string.gsub!(/(#{Regexp.quote(clear)}){2,}/, clear)
      end
      ansi_string
    end

    # Nest color
    #
    # @param [String] string
    #   the string to decorate
    #
    # @param [String] ansi_colors
    #   the ansi colors to apply
    #
    # @return [String]
    #
    # @api private
    def nest_color(string, ansi_colors)
      ansi_string = string.dup
      matches = ansi_string.scan(/#{Regexp.quote(clear)}/)
      if matches.length > 1
        ansi_string.sub!(/#{Regexp.quote(clear)}/, ansi_colors)
      end
      ansi_string
    end
    private :collapse_reset, :nest_color

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
    #   the string to sanitize
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
      attribute = []
      colors.each do |color|
        value = ANSI::ATTRIBUTES[color]
        if value
          attribute << value
        else
          validate(color)
        end
      end
      attribute
    end

    # Find color representation.
    #
    # @param [Symbol,String] colors
    #   the color name(s) to lookup
    #
    # @return [String]
    #   the ANSI code(s)
    #
    # @api private
    def lookup(*colors)
      attribute = code(*colors)
      "\e[#{attribute.join(';')}m"
    end

    # Expose all ANSI color names and their codes
    #
    # @return [Hash[Symbol]]
    #
    # @api public
    def styles
      ANSI::ATTRIBUTES
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
    #   the list of colors to check
    #
    # @reutrn [Boolean]
    #   true if all colors are valid, false otherwise
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
