require 'benchmark/ips'

require_relative '../lib/pastel'

pastel = Pastel.new

Benchmark.ips do |bench|
  bench.config(time: 5, warmup: 2)

  bench.report('color decorate') do
    pastel.decorate('string', :red, :on_green, :bold)
  end

  bench.report('dsl styling') do
    pastel.red.on_green.bold('string')
  end

  bench.compare!
end


# version 0.7.3
#
# Warming up --------------------------------------
#       color decorate     8.260k i/100ms
#          dsl styling     4.211k i/100ms
# Calculating -------------------------------------
#       color decorate     93.820k (± 2.3%) i/s -    470.820k in   5.021097s
#          dsl styling     44.655k (± 3.3%) i/s -    227.394k in   5.097981s
# 
# Comparison:
#       color decorate:    93819.7 i/s
#          dsl styling:    44654.6 i/s - 2.10x  slower
#

# version 0.6.0

# Calculating -------------------------------------
#       color decorate      7346 i/100ms
#          dsl styling      3436 i/100ms
# -------------------------------------------------
#       color decorate    96062.1 (±7.9%) i/s -     484836 in   5.081126s
#          dsl styling    38761.1 (±13.9%) i/s -     192416 in   5.065053s
#
# Comparison:
#       color decorate:    96062.1 i/s
#          dsl styling:    38761.1 i/s - 2.48x slower

# version 0.5.3

# Calculating -------------------------------------
#       color decorate      1428 i/100ms
#          dsl styling      1174 i/100ms
# -------------------------------------------------
#       color decorate    16113.1 (±21.5%) i/s -      77112 in   5.054487s
#          dsl styling    12622.9 (±20.8%) i/s -      61048 in   5.076738s
#
# Comparison:
#       color decorate:    16113.1 i/s
#          dsl styling:    12622.9 i/s - 1.28x slower
#
