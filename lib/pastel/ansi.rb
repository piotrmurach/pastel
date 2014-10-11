# encoding: utf-8

module Pastel
  # Mixin that provides ANSI codes
  module ANSI
    CLEAR         = "\e[0m"

    BOLD          = "\e[1m"
    DIM           = "\e[2m"
    ITALIC        = "\e[3m"
    UNDERLINE     = "\e[4m"
    INVERSE       = "\e[7m"
    HIDDEN        = "\e[8m"
    STRIKETHROUGH = "\e[9m"

    # Escape codes for text color.
    BLACK         = "\e[30m"
    RED           = "\e[31m"
    GREEN         = "\e[32m"
    YELLOW        = "\e[33m"
    BLUE          = "\e[34m"
    MAGENTA       = "\e[35m"
    CYAN          = "\e[36m"
    WHITE         = "\e[37m"

    BRIGHT_BLACK   = "\e[90m"
    BRIGHT_RED     = "\e[91m"
    BRIGHT_GREEN   = "\e[92m"
    BRIGHT_YELLOW  = "\e[93m"
    BRIGHT_BLUE    = "\e[94m"
    BRIGHT_MAGENTA = "\e[95m"
    BRIGHT_CYAN    = "\e[96m"
    BRIGHT_WHITE   = "\e[97m"

    # Escape codes for background color.
    ON_BLACK         = "\e[40m"
    ON_RED           = "\e[41m"
    ON_GREEN         = "\e[42m"
    ON_YELLOW        = "\e[43m"
    ON_BLUE          = "\e[44m"
    ON_MAGENTA       = "\e[45m"
    ON_CYAN          = "\e[46m"
    ON_WHITE         = "\e[47m"

    ON_BRIGHT_BLACK   = "\e[100m"
    ON_BRIGHT_RED     = "\e[101m"
    ON_BRIGHT_GREEN   = "\e[102m"
    ON_BRIGHT_YELLOW  = "\e[103m"
    ON_BRIGHT_BLUE    = "\e[104m"
    ON_BRIGHT_MAGENTA = "\e[105m"
    ON_BRIGHT_CYAN    = "\e[106m"
    ON_BRIGHT_WHITE   = "\e[107m"

    BACKGROUND_COLORS = constants.grep(/^ON_*/).freeze
  end # ANSI
end # Pastel
