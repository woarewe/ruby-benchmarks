# frozen_string_literal: true

require 'benchmark/ips'

ARRAY_SIZE = 1_000
ATTEMPTS_COUNT = 100_000
NUMBERS = Array.new(ARRAY_SIZE) { rand(100) }

Benchmark.ips do |x|
  x.report('reduce like .reduce(&:+)') do
    ATTEMPTS_COUNT.times do
      NUMBERS.reduce(&:+)
    end
  end

  x.report('reduce like .reduce(:+)') do
    ATTEMPTS_COUNT.times do
      NUMBERS.reduce(:+)
    end
  end

  x.report('reduce with block') do
    ATTEMPTS_COUNT.times do
      NUMBERS.reduce { |sum, number| sum + number }
    end
  end

  x.compare!
end
