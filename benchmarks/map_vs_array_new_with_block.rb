# frozen_string_literal: true

require 'benchmark/ips'

ARRAY_SIZE = 10_000_000

Benchmark.ips do |x|
  x.report('Array#new with map') do
    Array.new(ARRAY_SIZE).map { rand(ARRAY_SIZE) }
  end

  x.report('Array#new with block') do
    Array.new(ARRAY_SIZE) { rand(ARRAY_SIZE) }
  end

  x.report('Range with map') do
    (1..ARRAY_SIZE).map { rand(ARRAY_SIZE) }
  end

  x.compare!
end
