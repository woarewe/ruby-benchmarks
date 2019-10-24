# frozen_string_literal: true

require 'benchmark/ips'

ITERATIONS_COUNT = 100_000_000

class Base
  STEPS = [].freeze

  def via_const_get_with_symbol
    self.class.const_get(:STEPS)
  end

  def via_const_get_with_string
    self.class.const_get('STEPS')
  end

  def via_namespace
    self.class::STEPS
  end
end

class Child < Base
  STEPS = %i[one two three].freeze
end

object = Child.new

raise 'Wrong constant when via const get with string' unless object.via_const_get_with_string.equal?(Child::STEPS)
raise 'Wrong constant when via const get with symbol' unless object.via_const_get_with_symbol.equal?(Child::STEPS)
raise 'Wrong constant when via namespace' unless object.via_namespace.equal?(Child::STEPS)

Benchmark.ips do |x|
  x.report('via Module#const_get with string as param') do
    ITERATIONS_COUNT.times do
      object.via_const_get_with_string
    end
  end

  x.report('via Module#const_get with symbol as param') do
    ITERATIONS_COUNT.times do
      object.via_const_get_with_symbol
    end
  end

  x.report('via class implicit namespace') do
    ITERATIONS_COUNT.times do
      object.via_namespace
    end
  end

  x.compare!
end
