# frozen_string_literal: true

require 'benchmark/ips'

ATTEMPTS_COUNT = 1_000_000
CONST_ARY = %i[one two three four five six seven eight nine ten]
TEST_CASES = [:test, 1, 'foo', 4.3, Object.new].freeze

Benchmark.ips do |x|
  x.report('work with array in const') do
    ATTEMPTS_COUNT.times do
      CONST_ARY.include?(TEST_CASES.sample)
    end
  end

  x.report('work with literal') do
    ATTEMPTS_COUNT.times do
      %i[one two three four five six seven eight nine ten].include?(TEST_CASES.sample)
    end
  end

  x.compare!
end
