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

# color decorate: 14K/s
# dsl styling:    10K/s
