# frozen_string_literal: true

require 'benchmark/ips'

OUTER_ARRAY_SIZE = 1000
INNER_ARRAY_SIZE = 1000

ary = Array.new(OUTER_ARRAY_SIZE) { Array.new(INNER_ARRAY_SIZE) { rand(INNER_ARRAY_SIZE) } }
flat_map_result = nil
inject_result = nil
map_plus_flatten_result = nil

Benchmark.ips do |x|
  x.report('Array#flat_map') do
    flat_map_result = ary.flat_map(&:itself).uniq
  end

  x.report('Array#inject') do
    inject_result = ary.inject([]) { |result, current| result + current }.uniq
  end

  x.report('Array#map + flatten(1)') do
    map_plus_flatten_result = ary.map(&:itself).flatten(1)
  end

  raise 'Different result values' if inject_result != flat_map_result
  raise 'Different result values' if map_plus_flatten_result != flat_map_result
  raise 'Different result values' if inject_result != map_plus_flatten_result

  x.compare!
end
