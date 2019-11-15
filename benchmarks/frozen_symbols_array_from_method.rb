# frozen_string_literal: true

require 'benchmark/ips'

ATTEMPTS_COUNT = 10_000
ARRAY_SIZE = 10_000

class Wrapper
  def frozen_symbols_ary
    Array.new(ARRAY_SIZE) { |i| i.to_s.to_sym }.freeze
  end

  def not_frozen_symbols_ary
    Array.new(ARRAY_SIZE) { |i| i.to_s.to_sym }
  end
end

class Helper
  def self.test(ary)
    value = ary.sample
    ary.include?(value)
  end
end

wrapper = Wrapper.new

Benchmark.ips do |x|
  x.report('frozen symbols ary') do
    ATTEMPTS_COUNT.times do
      Helper.test(wrapper.frozen_symbols_ary)
    end
  end

  x.report('not frozen symbols ary') do
    ATTEMPTS_COUNT.times do
      Helper.test(wrapper.not_frozen_symbols_ary)
    end
  end

  x.compare!
end
