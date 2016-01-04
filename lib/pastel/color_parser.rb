# encoding: utf-8

module Pastel
  # Responsible for parsing color symbols out of text with color escapes
  #
  # Used internally by {Color}.
  #
  # @api private
  class ColorParser
    include ANSI

    ESC = "\x1b".freeze
    CSI = "\[".freeze

    # Parse color escape sequences into a list of hashes
    # corresponding to the color attributes being set by these
    # sequences
    #
    # @example
    #   parse("\e[32mfoo\e[0m") # => [{colors: [:green], text: 'foo'}
    #
    # @param [String] text
    #   the text to parse for presence of color ansi codes
    #
    # @return [Array[Hash[Symbol,String]]]
    #
    # @api public
    def self.parse(text)
      scanner = StringScanner.new(text)
      state = {}
      result = []
      ansi_stack = []
      text_chunk = ''

      until scanner.eos?
        char = scanner.getch
        # match control
        if char == ESC && (delim = scanner.getch) == CSI
          if scanner.scan(/^0m/)
            state = unpack_ansi(state, ansi_stack)
            ansi_stack = []
          elsif scanner.scan(/^([1-9;:]+)m/)
            # ansi codes separated by text
            if !text_chunk.empty? && !ansi_stack.empty?
              state = unpack_ansi(state, ansi_stack)
              ansi_stack = []
            end
            scanner[1].split(/:|;/).each do |code|
              ansi_stack << code
            end
          end

          if !text_chunk.empty?
            state[:text] = text_chunk
            result.push(state)
            state = {}
            text_chunk = ''
          end
        elsif char == ESC # broken escape
          text_chunk << char + delim.to_s
        else
          text_chunk << char
        end
      end

      if !text_chunk.empty?
        state[:text] = text_chunk
      end
      if !ansi_stack.empty?
        state = unpack_ansi(state, ansi_stack)
      end
      if state.values.any? { |val| !val.empty? }
        result.push(state)
      end
      result
    end

    # @api private
    def self.unpack_ansi(state, ansi_stack)
      ansi_stack.each do |ansi|
        name = ansi_for(ansi)
        if ANSI.foreground?(ansi)
          state[:foreground] = name
        elsif ANSI.background?(ansi)
          state[:background] = name
        elsif ANSI.style?(ansi)
          state[:style] = name
        end
      end
      state
    end

    # @api private
    def self.ansi_for(ansi)
      ATTRIBUTES.key(ansi.to_i)
    end
  end # Parser
end # Pastel
