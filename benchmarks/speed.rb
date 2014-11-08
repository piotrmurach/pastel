require 'pastel'
require 'benchmark/ips'

pastel = Pastel.new

Benchmark.ips do |bench|
  bench.config(time: 5, warmup: 2)

  bench.report('styles') do
    pastel.styles
  end

  bench.report('decorate') do
    pastel.decorate('string', :red, :on_green, :bold)
  end
end
