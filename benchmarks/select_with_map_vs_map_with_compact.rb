# frozen_string_literal: true

require 'benchmark/ips'
require 'ostruct'

ARRAY_SIZE = 10_000_000

ary = Array.new(ARRAY_SIZE).map { rand(ARRAY_SIZE) }
open_struct = OpenStruct.new

Benchmark.ips do |x|
  x.report('select with map') do
    open_struct.selected_ary = ary.select(&:odd?).map(&Math.method(:sqrt))
  end

  x.report('map with compact') do
    open_struct.compacted_ary = ary.map do |number|
      next if number.even?

      Math.sqrt(number)
    end.compact
  end

  raise 'Arrays are different' if open_struct.selected_ary != open_struct.compacted_ary
  x.compare!
end
