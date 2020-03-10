# frozen_string_literal: true

require 'benchmark/ips'
require 'ostruct'

ARRAY_SIZE = 10**8

ary = Array.new(ARRAY_SIZE).map { rand(ARRAY_SIZE) }
open_struct = OpenStruct.new

Benchmark.ips do |x|
  x.report('select with size') do
    open_struct.selected_size = ary.select(&:odd?).size
  end

  x.report('count with block') do
    open_struct.counted_size = ary.count(&:odd?)
  end

  raise 'Values are different' if open_struct.selected_size != open_struct.counted_size

  x.compare!
end
