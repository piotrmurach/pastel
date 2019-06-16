require 'benchmark/ips'

require_relative '../lib/pastel'

pastel = Pastel.new

Benchmark.ips do |bench|
  bench.config(time: 5, warmup: 2)

  bench.report('regular nesting') do
    pastel.red.on_green('Unicorns' +
      pastel.green.on_red('will ', 'dominate' + pastel.yellow('the world!')))
  end

  bench.report('block nesting') do
    pastel.red.on_green('Unicorns') do
      green.on_red('will ', 'dominate') do
        yellow('the world!')
      end
    end
  end

  bench.compare!
end

# version 0.7.2
#
# Warming up --------------------------------------
#      regular nesting     1.682k i/100ms
#        block nesting     1.505k i/100ms
# Calculating -------------------------------------
#      regular nesting     17.442k (± 2.0%) i/s -     87.464k in   5.016577s
#        block nesting     15.503k (± 2.3%) i/s -     78.260k in   5.050593s
# 
# Comparison:
#      regular nesting:    17442.0 i/s
#        block nesting:    15503.3 i/s - 1.13x  slower
# 

# version 0.6.0

# Calculating -------------------------------------
#      regular nesting      1282 i/100ms
#        block nesting      1013 i/100ms
# -------------------------------------------------
#      regular nesting    13881.5 (±16.3%) i/s -      67946 in   5.043220s
#        block nesting    11411.6 (±25.4%) i/s -      53689 in   5.088911s
#
# Comparison:
#      regular nesting:    13881.5 i/s
#        block nesting:    11411.6 i/s - 1.22x slower

# version 0.5.3

# regular nesting: 2800/s
# block nesting:   2600/s
