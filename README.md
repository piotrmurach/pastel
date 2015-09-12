<h1 align="center">
  <img width="215" src="https://github.com/peter-murach/pastel/raw/master/assets/pastel_logo.svg" alt="pastel logo" />
</h1>
# Pastel
[![Gem Version](https://badge.fury.io/rb/pastel.png)][gem]
[![Build Status](https://secure.travis-ci.org/peter-murach/pastel.png?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/peter-murach/pastel.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/peter-murach/pastel/badge.png)][coverage]

[gem]: http://badge.fury.io/rb/pastel
[travis]: http://travis-ci.org/peter-murach/pastel
[codeclimate]: https://codeclimate.com/github/peter-murach/pastel
[coverage]: https://coveralls.io/r/peter-murach/pastel

> Terminal output styling with intuitive and clean API that doesn't monkey patch String class.

**Pastel** is minimal and focused to work in all terminal emulators.

![screenshot](https://github.com/peter-murach/pastel/raw/master/assets/screenshot.png)

**Pastel** provides independent coloring component for [TTY](https://github.com/peter-murach/tty) toolkit.

## Features

* Doesn't monkey patch `String`
* Intuitive and expressive API
* Minimal and focused to work on all terminal emulators
* Auto-detection of color support
* Performant

## Installation

Add this line to your application's Gemfile:

    gem 'pastel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pastel

## Contents

* [1. Usage](#1-usage)
* [2. Interface](#2-interface)
  * [2.1 Color](#21-color)
  * [2.2 Decorate](#22-decorate)
  * [2.3 Detach](#23-detach)
  * [2.4 Strip](#24-strip)
  * [2.5 Styles](#25-styles)
  * [2.6 Valid?](#26-valid)
  * [2.7 Enabled?](#27-enabled)
  * [2.8 Alias Color](#28-alias-color)
* [3. Supported Colors](#3-supported-colors)
* [4. Environment](#4-environment)

## 1 Usage

**Pastel** provides a simple, minimal and intuitive API for styling your strings:

```ruby
pastel = Pastel.new

pastel.red('Unicorns!')
```

You can compose multiple styles through chainable API:

```ruby
pastel.red.on_green.bold('Unicorns!')
```

It allows you to combine styled strings with unstyled ones:

```ruby
pastel.red('Unicorns') + ' will rule ' + pastel.green('the World!')
```

It supports variable number of arguments:

```ruby
pastel.red('Unicorns', 'are', 'running', 'everywhere!')
```

You can also nest styles as follows:

```ruby
pastel.red('Unicorns ', pastel.on_green('everywhere!'))
```

Nesting is smart enough to know where one color ends and another one starts:

```ruby
pastel.red('Unicorns ' + pastel.green('everywhere') + pastel.on_yellow('!'))
```

You can also nest styles inside blocks:

```ruby
pastel.red.on_green('Unicorns') {
  green.on_red('will ', 'dominate') {
    yellow('the world!')
  }
}
```

You can also predefine needed styles and reuse them:

```ruby
error    = pastel.red.on_bold.detach
warning  = pastel.yellow.detach

puts error('Error!')
puts warning('Warning')
```

## 2 Interface

### 2.1 Color pastel.<color>[.<color>...](string, [string...])

Color styles are invoked as method calls with a string argument. A given color can take any number of strings as arguments. Then it returns a colored string which isn't printed out to terminal. You need to print it yourself if you need to. This is done so that you can save it as a string, pass to something else, send it to a file handle and so on.

```ruby
pastel.red('Unicorns ', pastel.bold.underline('everywhere'), '!')
```

Please refer to [3. Supported Colors](#3-supported-colors) section for full list of supported styles.

### 2.2 Decorate

This method is a lower level string styling call that takes as the first argument the string to style followed by any number of color attributes, and returns string wrapped in styles.

```ruby
pastel.decorate('Unicorn', :green, :on_blue, :bold)
```

This method will be useful in situations where colors are provided as a list of parameters have been generated dynamically.

### 2.3 Detach

The `detach` method allows to keep all the coloring for later reference. This method is useful when detached colors are being resued frequently and thus shorthand version is preferred.

```ruby
notice = pastel.blue.bold.detach
puts notice.call('Unicorns running')
puts notice.call('They are super wild')
```

### 2.4 Strip

Strip all color sequence characters from the provided strings. The return value will be eithre array of modified strings or a single string. The arguments are not modified.

```ruby
pastel.strip("\e[1m\e[34mbold blue text\e[0m")  # => "bold blue text"
```

### 2.5 Styles

To get a full list of supported styles with the corresponding color codes do:

```ruby
pastel.styles
```

### 2.6 Valid?

Determine whether a color or a list of colors are valid. `valid?` takes one or more attribute strings or symbols and returns true if all attributes are known and false otherwise.

```ruby
pastel.valid?(:red, :blue) # => true
pastel.valid?(:unicorn)    # => false
```

### 2.7 Enabled?

In order to detect if your terminal supports coloring do:

```ruby
pastel.enabled?   # => false
```

In cases when the color support is not provided no styling will be applied to the colored string. Moreover, you can force **Pastel** to always print out string with coloring switched on:

```ruby
pastel = Pastel.new(enabled: true)
pastel.enabled?   # => false
```

### 2.8 Alias Color

In order to setup an alias for the standard color do:

```ruby
pastel.alias_color(:funky, :red)
```

From that point forward, `:funky` alias can be passed to `decorate`, `valid?` with the same meaning as standard color:

```ruby
pastel.funky.on_green('unicorn')   # => will use :red color
```

This method allows you to give more meaningful names to existing colors.

You can also use the `PASTEL_COLORS_ALIASES` environment variable (see [Environment](#4-environment)) to specify aliases.

Note: Aliases are global and affect all callers in the same process.

## 3 Supported Colors

**Pastel** works with terminal emulators that support minimum sixteen colors. It provides `16` basic colors and `8` styles with further `16` bright color pairs. The corresponding bright color is obtained by prepending the `bright` to the normal color name. For example, color `red` will have `bright_red` as its pair.

The variant with `on_` prefix will style the text background color.

The foreground colors:

* `black`
* `red`
* `green`
* `yellow`
* `blue`
* `magenta`
* `cyan`
* `white`
* `bright_black`
* `bright_red`
* `bright_green`
* `bright_yellow`
* `bright_blue`
* `bright_magenta`
* `bright_cyan`
* `bright_white`

The background colors:

* `on_black`
* `on_red`
* `on_green`
* `on_yellow`
* `on_blue`
* `on_magenta`
* `on_cyan`
* `on_white`
* `on_bright_black`
* `on_bright_red`
* `on_bright_green`
* `on_bright_yellow`
* `on_bright_blue`
* `on_bright_magenta`
* `on_bright_cyan`
* `on_bright_white`

Generic styles:

* `clear`
* `bold`
* `dim`
* `italic`
* `underline`
* `inverse`
* `hidden`
* `strikethrough`

## 4 Environment

### 4.1 PASTEL_COLORS_ALIASES

This environment variable allows you to specify custom color aliases at runtime that will be understood by **Pastel**. The environment variable is read and used when the instance of **Pastel** is created. You can also use `alias_color` to create aliases.

Only alphanumeric and `_` are allowed in the alias names with the following format:

```ruby
PASTEL_COLORS_ALIASES='newcolor_1=red,newcolor_2=on_green'
```

## Contributing

1. Fork it ( https://github.com/peter-murach/pastel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright (c) 2014-2015 Piotr Murach. See LICENSE for further details.
