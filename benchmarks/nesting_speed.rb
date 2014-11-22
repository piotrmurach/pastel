require 'pastel'
require 'benchmark/ips'

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

# regular nesting: 2800/s
# block nesting:   2600/s
