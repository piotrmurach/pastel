require 'pastel'
require 'benchmark/ips'

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
