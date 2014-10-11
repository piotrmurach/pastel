# Pastel
[![Gem Version](https://badge.fury.io/rb/pastel.png)][gem]
[![Build Status](https://secure.travis-ci.org/peter-murach/pastel.png?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/peter-murach/pastel.png)][codeclimate]

[gem]: http://badge.fury.io/rb/pastel
[travis]: http://travis-ci.org/peter-murach/pastel
[codeclimate]: https://codeclimate.com/github/peter-murach/pastel

Terminal output styling with intuitive and clean API that doesn't monkey patch String class.

**Pastel** is minimal and focused to work in all terminal emulators.

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
  * [2.3 Strip](#23-strip)
  * [2.4 Styles](#24-styles)
  * [2.5 Valid?](#25-valid)
* [3. The available styles](#3-the-available-styles)

## 1 Usage

**Pastel** provides a simple, minimal and intuitive API for styling your strings:

```ruby
pastel = Pastel.new

pastel.red('Unicorns!')
```

It allows you to combine styled strings with regular ones:

```ruby
pastel.red('Unicorns') + ' will rule ' + pastel.green('the World!')
```

You can compose multiple styles through chainable API:

```ruby
pastel.red.on_green.bold('Unicorns!')
```

It supports variable number of arguments with individual styling:

```ruby
pastel.red('Unicorns', 'are', 'running', 'everywhere!')
```

You can also nest styles as follows:

```ruby
pastel.red('Unicorns ', pastel.on_green('everywhere!'))
```

## 2 Interface

### 2.1 Color

You can pass variable number of styled strings like so:

```ruby
pastel.red('Unicorns', pastel.on_yellow('are running', pastel.bold.underline('everywhere')), '!')
```

Please refer to [3. The available styles](#3-the-available-styles) section for full list of supported styles.

### 2.2 Decorate

This method is a lower level string styling call that takes as the first argument the string to style and any number of attributes, and returns string wrapped in styles.

```ruby
pastel.decorate('Unicorn', :green, :on_blue, :bold)
```

### 2.3 Strip

Strip all color sequence characters:

```ruby
pastel.strip("\e[1m\e[34mbold blue text\e[0m"")  # => "bold blue text"
```

### 2.4 Styles

To get a full list of supported styles with the corresponding color codes do:

```ruby
pastel.styles
```

### 2.5 Valid?

Determine whether a color is valid:

```ruby
pastel.valid?(:red)     # => true
pastel.valid?(:unicorn) # => false
```

## 3 The available styles

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

## Contributing

1. Fork it ( https://github.com/[my-github-username]/pastel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright (c) 2014 Piotr Murach. See LICENSE for further details.
